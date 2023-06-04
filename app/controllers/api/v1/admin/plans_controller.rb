# frozen_string_literal: true

class Api::V1::Admin::PlansController < AdministratorController
  before_action :set_plan, except: %i[index create statistics_by_subscriptions statistics_by_revenue]

  def index
    plans = Plan.filter(params)

    paginate plans,
             each_serializer: Admin::PlansSerializer
  end

  def show
    expose @plan,
           serializer: Admin::PlansSerializer
  end

  def create
    Plan.create!(plan_params)

    expose
  end

  def update
    @plan.update!(plan_params)

    expose
  end

  def destroy
    @plan.destroy!

    expose
  end

  def statistics_by_subscriptions
    year = params[:year]
    month = params[:month]
    stat_object = params[:stat_object]
    stat_object = stat_object && (stat_object == 'subscriptions' || stat_object == 'revenue') ? stat_object.to_sym : :subscriptions

    plans = Plan.all

    statistics = if year.present?
                   if month.present?
                     Plan.statistics_by_days(year.to_i, month.to_i, plans.pluck(:id), stat_object)
                   else
                     Plan.statistics_by_months(year, plans.pluck(:id), stat_object)
                   end
                 else
                   Plan.statistics_by_years(plans.pluck(:id), stat_object)
                 end

    data = {
      objects: plans.select(:id, :name),
      stats: statistics
    }

    expose data
  end

  def statistics_by_revenue
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan)
          .permit(:name, :description, :price, :value)
  end
end
