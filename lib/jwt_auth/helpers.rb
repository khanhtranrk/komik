# frozen_string_literal: true

module JwtAuth
  module Helpers
    def login!(user)
      access_token, refresh_token = JwtAuth::Issuer.access_and_refresh_token(user)
      { access_token:, refresh_token: }
    end

    def refresh!
      access_token = request.headers['Authorization']&.split('Bearer ')&.last
      refresh_token = request.headers['Refresh-Token']

      raise JwtAuth::Errors::MissingToken, I18n.t('jwt_auth.errors.missing_token') unless access_token || refresh_token

      decoded_token = JwtAuth::JsonWebToken.decode(access_token, verify: false)

      refrezh_token = RefreshToken.find_by(
        'user_id = ? AND token = ? AND expire_at > NOW()',
        decoded_token[:user_id], refresh_token
      )

      raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token') unless refrezh_token

      refrezh_token.destroy!

      access_token, refresh_token = JwtAuth::Issuer.access_and_refresh_token(decoded_token[:user_id])

      { access_token:, refresh_token: }
    end

    def logout!
      token = request.headers['Refresh-Token']
      user = @current_user

      RefreshToken.find_by!(user:, token:)
                  .destroy!
      nil
    end
  end
end
