# frozen_string_literal: true

class Chapter < ApplicationRecord
  default_scope { order(created_at: :asc) }

  has_many_attached :images

  belongs_to :comic

  has_many :reading_chapters, dependent: :delete_all
end
