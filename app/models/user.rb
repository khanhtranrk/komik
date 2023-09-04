# frozen_string_literal: true

class User < ApplicationRecord
  include Notificationable

  has_secure_password

  has_one_attached :avatar

  has_one :verification, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :session, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, :email, uniqueness: true
  validates :username,
            :email,
            presence: true
  validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: 'chỉ chứa các kí tự chữ cái, chữ số, dấu gạch dưới và dấu gạch ngang' }

  validates :birthday, timeliness: { on_or_before: -> { Time.zone.now }, type: :date }
  validates :birthday, timeliness: { on_or_after: -> { Time.zone.parse('1900-01-01 00:00:00') }, type: :date }

  REQUIRED_ATTRIBUTES = %i[username email password].freeze

  def current_plan
    purchases.find_by('NOW()::TIMESTAMP > effective_at::TIMESTAMP AND NOW()::TIMESTAMP < expires_at::TIMESTAMP')
  end

  class << self
    def filter(params)
      users = all.order(id: :asc)

      if params[:query].present?
        query = params[:query].strip

        users = users.where('username ILIKE ? OR email ILIKE ?', "%#{query}%", "%#{query}%")
      end

      if params[:sort_by].present?
        sort_by = params[:sort_by].split(',').map { |t| t.split('-') }
        sort_by = sort_by.select { |t| t[0].in?(%w[username email created_at]) && t[1].in?(%w[asc desc]) }
        sort_by = sort_by.map { |t| "users.#{t[0]} #{t[1]}" }

        users = categories.order(sort_by.join(', '))
      end

      users
    end
  end
end
