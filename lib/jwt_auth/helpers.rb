# frozen_string_literal: true

module JwtAuth
  module Helpers
    def login!(user)
      JwtAuth::LoginHelper.create_login!(user.id)
    end

    def refresh!
      access_token = request.headers['Authorization']&.split('Bearer ')&.last
      refresh_token = request.headers['Refresh-Token']

      raise JwtAuth::Errors::MissingToken, I18n.t('jwt_auth.errors.missing_token') unless access_token || refresh_token

      decoded_token = JwtAuth::JsonWebToken.decode(access_token, verify: false)

      login = Login.find_by(user_id: decoded_token[:user_id], token: refresh_token, access_token:)

      raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token') if !login

      if login.expire_at < Time.zone.now
        login.destroy!
        raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token')
      end

      JwtAuth::LoginHelper.update_login!(login)
    end

    def logout!
      access_token = request.headers['Authorization']&.split('Bearer ')&.last
      refresh_token = request.headers['Refresh-Token']

      raise JwtAuth::Errors::MissingToken, I18n.t('jwt_auth.errors.missing_token') unless access_token || refresh_token

      decoded_token = JwtAuth::JsonWebToken.decode(access_token, verify: false)

      login = Login.find_by(user_id: decoded_token[:user_id], token: refresh_token, access_token:)

      raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token') if !login

      Login.find_by!(user:, token:)
           .destroy!

      nil
    end
  end
end
