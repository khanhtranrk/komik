# frozen_string_literal: true

class Login < ApplicationRecord
  belongs_to :user

  has_one :device, dependent: :destroy
end
