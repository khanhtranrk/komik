# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true

  class << self
    def filter(params)
      feedbacks = all.order(id: :desc)

      if params[:query].present?
        query = params[:query].strip

        feedbacks = feedbacks.joins(:user).where(
          'feedbacks.title ILIKE ? OR users.username ILIKE ? OR users.email ILIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%"
        )
      end

      if params[:from_date].present?
        feedbacks = feedbacks.where(
          'created_at::DATE >= ?::DATE',
          Date.parse(params[:from_date])
        )
      end

      if params[:to_date].present?
        feedbacks = feedbacks.where(
          'created_at::DATE <= ?::DATE',
          Date.parse(params[:to_date])
        )
      end

      feedbacks
    end
  end
end
