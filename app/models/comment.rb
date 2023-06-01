# frozen_string_literal: true

class Comment < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :comic
end
