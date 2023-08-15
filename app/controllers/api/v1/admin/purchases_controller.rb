# frozen_string_literal: true

class Api::V1::Admin::PurchasesController < AdministratorController
  before_action :set_purchase, except: %i[index show]

  def index
    purchases = Purchase.filter(params)

    paginate purchases,
             each_serializer: Admin::PurchaseSerializer,
             base_url: request.base_url
  end

  def show
    expose @purchase,
           serializer: Admin::PurchaseSerializer
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end
end
