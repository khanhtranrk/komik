# frozen_string_literal: true

class Api::V1::App::PurchasesController < ApplicationController
  before_action :validate_purchase!, only: %i[card]

  def stripe_key
    expose key: ENV['STRIPE_PUBLISHABLE_KEY']
  end

  def index
    purchases = @current_user.purchases
                             .order(created_at: :desc)

    paginate purchases,
             each_serializer: App::PurchaseSerializer
  end

  def card
    # find plan
    plan = Plan.find(purchase_params[:plan_id])

    # create a purchase
    purchase = Purchase.create!(
      user_id: @current_user.id,
      plan_id: plan.id,
      price: plan.price,
      payment_method: :card
    )

    # pay with stripe
    customer = Stripe::Customer.create email: @current_user.email,
                                       source: purchase_params[:token]

    Stripe::Charge.create customer: customer.id,
                          amount: plan.price.to_i,
                          description: 'description',
                          currency: 'vnd'

    # update purchase
    current_time = Time.zone.now

    purchase.update!(
      effective_date: current_time,
      expiry_date: current_time + plan.value.hours
    )

    # send notify
    @current_user.send_notification(
      Noti::Message.new(
        template: 'payment.successful',
        plan_name: plan.name
      ).as_json
    )

    expose
  rescue StandardError => e
    # detroy purchase
    purchase.destroy!

    expose_error message: e.message,
                 status: :payment_required,
                 key: :PAYMENT_REQUIRED
  end

  private

  def validate_purchase!
    raise Errors::InvalidCall, t(:exists_plan) if @current_user.current_plan.present?
  end

  def purchase_params
    params.require(:purchase)
          .permit(:plan_id, :token)
  end
end
