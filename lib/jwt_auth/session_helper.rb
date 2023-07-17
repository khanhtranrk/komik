# frozen_string_literal: true

module JwtAuth
  module SessionHelper
    module_function

    def expire_at
      Time.now.utc + JwtAuth.refresh_token_validity
    end

    def generate_refresh_token
      SecureRandom.urlsafe_base64
    end

    def create_session!(user_id)
      refresh_token = generate_refresh_token
      access_token = JwtAuth::JsonWebToken.encode(user_id)
      Session.create!(user_id:, refresh_token:, access_token:, expire_at:)
    end

    def update_session!(session)
      access_token = JwtAuth::JsonWebToken.encode(session.user_id)
      session.update!(access_token:)
      session
    end
  end
end
