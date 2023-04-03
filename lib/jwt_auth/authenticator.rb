# frozen_string_literal: true

module JwtAuth
  module Authenticator
    def authenticate!
      token = request.headers['Authorization']&.split('Bearer ')&.last
      raise JwtAuth::Errors::MissingToken, I18n.t('jwt_auth.errors.missing_token') unless token

      decoded_token = JwtAuth::JsonWebToken.decode(token)
      @current_user = User.find(decoded_token[:user_id])

      Login.find_by!(user: @current_user, access_token: token)
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
