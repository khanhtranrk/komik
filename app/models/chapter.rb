# frozen_string_literal: true

class Chapter < ApplicationRecord
  has_many_attached :images
  belongs_to :comic
end
