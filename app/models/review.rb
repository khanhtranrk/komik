# frozen_string_literal: true

class Review < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  scope :include_evaluate_statistic, lambda { |user_id|
    select('reviews.*')
      .select(
        'SUM(CASE WHEN evaluates.point_of_view = 1 THEN 1 ELSE 0 END) AS agreement_count'\
        ', SUM(CASE WHEN evaluates.point_of_view = 2 THEN 1 ELSE 0 END) AS disagreement_count'\
        ', SUM(CASE WHEN evaluates.point_of_view = 3 THEN 1 ELSE 0 END) AS transgression_count'\
        ", MAX(CASE WHEN evaluates.user_id = #{user_id} THEN evaluates.point_of_view ELSE 0 END) AS point_of_view"
      )
      .joins('LEFT JOIN evaluates ON evaluates.review_id = reviews.id')
      .group('reviews.id')
  }

  belongs_to :user
  belongs_to :comic

  has_many :evaluates, dependent: :destroy

  validates :title,
            :content,
            presence: true
end
