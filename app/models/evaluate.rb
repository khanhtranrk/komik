# frozen_string_literal: true

class Evaluate < ApplicationRecord
  belongs_to :review
  belongs_to :user
end
