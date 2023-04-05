# frozen_string_literal: true

class Api::V1::Admin::PlansController < AdministratorController
  before_action :set_plan, except: %i[index create]

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

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan)
          .permit(:name, :description, :price, :value)
  end
end
