# frozen_string_literal: true

module JwtAuth
  module Authenticator
    def authenticate!
      access_token = request.headers['Authorization']&.split('Bearer ')&.last
      raise JwtAuth::Errors::MissingToken, I18n.t('jwt_auth.errors.missing_token') unless access_token

      decoded_token = JwtAuth::JsonWebToken.decode(access_token)
      @current_user = User.find_by!(id: decoded_token[:user_id], locked: false)

      Session.find_by!(user: @current_user, access_token: token)
    rescue JWT::DecodeError
      raise JwtAuth::Errors::Unauthorized, I18n.t('jwt_auth.errors.unauthorized')
    rescue JWT::ExpiredSignature
      raise JwtAuth::Errors::Unauthorized, I18n.t('jwt_auth.errors.unauthorized')
    rescue ActiveRecord::RecordNotFound
      raise JwtAuth::Errors::Unauthorized, I18n.t('jwt_auth.errors.unauthorized')
    end

    def must_be_admin!
      raise JwtAuth::Errors::PermissionDenied, I18n.t('jwt_auth.errors.permission_denied') if @current_user.role.zero?
    end
  end
end
