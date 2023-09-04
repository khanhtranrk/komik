# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  class << self
    def filter(params)
      purchases = all.order(id: :desc)

      if params[:query].present?
        query = params[:query].strip

        purchases = purchases.joins(:users)
                             .where(
                               'username ILIKE ? OR email ILIKE ? OR firstname ILIKE ? OR lastname ILIKE ?',
                               "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
                             )
      end

      if params[:from_date].present? && params[:to_date].present?
        from_date = params[:from_date].to_date
        to_date = params[:to_date].to_date

        purchases = purchases.where('created_at >= ? AND created_at <= ?', from_date, to_date)
      end

      purchases
    end
  end
end
