module Notificationable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, dependent: :delete_all
  end

  def send_notification(message)
    Notify::PushJob.perform_later([id], message)
  end

  class_methods do
    def send_notification(message)
      Notify::PushJob.perform_later(ids, message)
    end
  end
end
