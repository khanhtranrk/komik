# frozen_string_literal: true

module JwtAuth
  module JsonWebToken
    module_function

    def secret_key
      Rails.application.secrets.secret_key_base.to_s
    end

    def exp
      (Time.zone.now + JwtAuth.token_validity).to_i
    end

    def iat
      Time.zone.now.to_i
    end

    def decode(token, verify: true)
      HashWithIndifferentAccess.new JWT.decode(token, secret_key, verify, verify_iat: true)[0]
    end

    def encode(user_id)
      payload = { user_id:, exp:, iat: }

      JWT.encode(payload, secret_key)
    end
  end
end
