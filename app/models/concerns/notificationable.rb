# frozen_string_literal: true

module Notificationable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, dependent: :delete_all
  end

  def send_notification(message)
    Notify::PushJob.perform_now([id], message)
  end

  class_methods do
    def send_notification(message)
      Notify::PushJob.perform_now(ids, message)
    end
  end
end
