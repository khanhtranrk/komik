# frozen_string_literal: true

class Evaluate < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :point_of_view, presence: true
  validates :user_id, uniqueness: { scope: :review_id }

  enum point_of_view: {
    agreement: 1,
    disagreement: 2,
    transgression: 3
  }
end
