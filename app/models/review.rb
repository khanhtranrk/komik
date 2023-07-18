# frozen_string_literal: true

class Review < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  validates :title,
            :content,
            presence: true

  belongs_to :user
  belongs_to :comic
end
