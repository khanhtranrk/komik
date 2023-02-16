# frozen_string_literal: true

class Notify::PushJob < ApplicationJob
  queue_as :notification
  sidekiq_options retry: Rails.configuration.contants.sidekig_retry,
                  backtrace: Rails.configuration.contants.sidekig_backtrace

  def perform(user, message, **options)
    sender = Noti::Exponent.new(message)

    if options.try(:only_lastest_device) == true
      device = Device.owned_by(user)
                     .order(updated_at: :desc)
                     .first

      sender.send_to(device.exponent_token) if device
    else
      exponent_tokens = Device.owned_by(user).pluck(:exponent_token)
      sender.send_to(exponent_tokens)
    end

    # store message
    Notification.create(user: user, message: message) unless options.try(:store_message) == false
  end
end
