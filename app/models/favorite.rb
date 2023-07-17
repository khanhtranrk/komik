# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :comic

  validates :user, uniqueness: { scope: %i[comic_id] }
end
