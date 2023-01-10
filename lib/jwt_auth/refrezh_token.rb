# frozen_string_literal: true

module JwtAuth
  module RefrezhToken
    module_function

    def expire_at
      Time.now.utc + JwtAuth.refresh_token_validity
    end

    def generate_refresh_token
      SecureRandom.urlsafe_base64
    end

    def new_refresh_token(user_id)
      token = generate_refresh_token
      RefreshToken.create(user_id:, token:, expire_at:).token
    end
  end
end
