# frozen_string_literal: true

class Plan < ApplicationRecord
  class << self
    def filter(params)
      plans = all.order(id: :asc)

      if params[:query].present?
        query = params[:query].strip

        plans = plans.where('name ILIKE ?', "%#{query}%")
      end

      plans
    end
  end
end
