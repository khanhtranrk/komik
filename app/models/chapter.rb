# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :comic
  has_many :images, as: :imageable, dependent: :delete_all
end
