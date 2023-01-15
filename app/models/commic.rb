# frozen_string_literal: true

class Commic < ApplicationRecord
  has_and_belongs_to_many :categories

  has_many :chapters, dependent: :delete_all
end
