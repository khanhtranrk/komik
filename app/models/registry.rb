# frozen_string_literal: true

class Registry < ApplicationRecord
  validates :key, uniqueness: true
  validates :key, presence: true
end
