# frozen_string_literal: true

class ComicsCategory < ApplicationRecord
  belongs_to :comic
  belongs_to :category
end
