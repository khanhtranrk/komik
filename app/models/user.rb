# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :refresh_tokens, dependent: :delete_all

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, :email, uniqueness: true
  validates :username,
            :email,
            :password,
            presence: true

  REQUIRED_ATTRIBUTES = %i[username email password].freeze
end
