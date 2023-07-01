# frozen_string_literal: true

class Author < ApplicationRecord
  has_one_attached :image

  has_many :authors_comics, dependent: :destroy
  has_many :comics, through: :authors_comics
end
