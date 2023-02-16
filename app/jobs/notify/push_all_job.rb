# frozen_string_literal: true

class Notify::PushAllJob < ApplicationJob
  queue_as :notification
  sidekiq_options retry: Rails.configuration.contants.sidekig_retry,
                  backtrace: Rails.configuration.contants.sidekig_backtrace

  def perform(message)
    sender = Noti::Exponent.new(message)
    exponent_tokens = Device.all.pluck(:exponent_token)
    sender.send_to(exponent_tokens)
  end
end
