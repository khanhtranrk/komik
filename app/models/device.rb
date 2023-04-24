# frozen_string_literal: true

class Device < ApplicationRecord
  scope :owned_by, ->(user_id) { where(login_id: Login.where(user_id:)) }

  belongs_to :login
end
