# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar

  has_many :refresh_tokens, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :follows, dependent: :delete_all
  has_many :reading_chapters, dependent: :delete_all
  has_many :purchases, dependent: :delete_all

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, :email, uniqueness: true
  validates :username,
            :email,
            presence: true

  REQUIRED_ATTRIBUTES = %i[username email password].freeze

  def current_plan
    purchases.find_by('NOW()::TIMESTAMP > effective_date::TIMESTAMP AND NOW()::TIMESTAMP < expiry_date::TIMESTAMP')
  end
end
