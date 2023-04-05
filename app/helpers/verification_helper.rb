# frozen_string_literal: true

module VerificationHelper
  extend ActiveSupport::Concern

  included do
    def send_verification_code_to(user)
      code = (0..9).to_a.sample(Rails.configuration.contants.verification_code_length).join
      expire_at = Time.zone.now + Rails.configuration.contants.verification_code_expiration.seconds
      user_id = user.id

      if user.verification
        user.verification.update!(code:, expire_at:)
      else
        Verification.create!(user_id:, code:, expire_at:)
      end

      VerificationMailer.verify(user.email, code).deliver_later
    end

    def verification_code_valid?(user, code)
      verification = Verification.find_by(user_id: user.id, code:)

      return false unless verification

      verification.destroy

      true
    end
  end
end
