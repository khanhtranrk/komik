# frozen_string_literal: true

class Notify::PushJob < ApplicationJob
  queue_as :notification
  sidekiq_options retry: Rails.configuration.contants.sidekig_retry,
                  backtrace: Rails.configuration.contants.sidekig_backtrace

  def perform(user_ids, message, **options)
    sender = Noti::Exponent.new(message)
    exponent_tokens = []

    if options.try(:only_lastest_device) == true
      user_ids.each do |user_id|
        device = Device.owned_by(user_id)
                       .order(updated_at: :desc)
                       .first

        exponent_tokens << device.exponent_tokens if device
      end
    else
      exponent_tokens = Device.owned_by(user_ids).pluck(:exponent_token)
    end

    sender.send_to(exponent_tokens)

    return if options.try(:store_message) == false

    # store message
    notifications = []

    user_ids.each do |user_id|
      notifications << Notification.new(user_id:, message:)
    end

    Notification.import(notifications)
  end
end
