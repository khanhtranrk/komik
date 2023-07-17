# frozen_string_literal: true

module JwtAuth
  module Helpers
    def login!(user)
      JwtAuth::SessionHelper.create_session!(user.id)
    end

    def refresh!
      access_token = request.headers['Authorization']&.split('Bearer ')&.last
      refresh_token = request.headers['Refresh-Token']

      raise JwtAuth::Errors::MissingToken, I18n.t('jwt_auth.errors.missing_token') unless access_token || refresh_token

      decoded_token = JwtAuth::JsonWebToken.decode(access_token, verify: false)

      session = Session.find_by(user_id: decoded_token[:user_id], refresh_token:, access_token:)

      raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token') unless session

      raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token') if session.user.locked

      if session.expire_at < Time.zone.now
        session.destroy!
        raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token')
      end

      JwtAuth::SessionHelper.update_session!(session)
    end

    def logout!
      access_token = request.headers['Authorization']&.split('Bearer ')&.last
      refresh_token = request.headers['Refresh-Token']

      raise JwtAuth::Errors::MissingToken, I18n.t('jwt_auth.errors.missing_token') unless access_token || refresh_token

      decoded_token = JwtAuth::JsonWebToken.decode(access_token, verify: false)

      session = Session.find_by(user_id: decoded_token[:user_id], refresh_token:, access_token:)

      raise JwtAuth::Errors::InvalidToken, I18n.t('jwt_auth.errors.invalid_token') unless login

      Session.find_by!(user: session.user, refresh_token:)
             .destroy!

      nil
    end
  end
end
