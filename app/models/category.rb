# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :comics_categories, dependent: :delete_all
  has_many :comics, through: :comics_categories
end
