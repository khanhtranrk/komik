# frozen_string_literal: true

class Comment < ApplicationRecord
  default_scope { order(updated_at: :desc) }

  belongs_to :user
  belongs_to :comic
end
