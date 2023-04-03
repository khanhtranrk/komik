# frozen_string_literal: true

module ErrorHandler
  module Rescuers
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        expose_error(
          status: :internal_server_error,
          key: :SERVER_ERROR,
          message: I18n.t('error_handler.server_error'),
          debug: e.message
        )
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        expose_error(
          status: :not_found,
          key: :NOT_FOUND,
          message: I18n.t('error_handler.not_found'),
          debug: e.message
        )
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        expose_error(
          status: :unprocessable_entity,
          key: :BAD_PARAMETER,
          message: e.record.errors.full_messages.to_sentence
        )
      end

      rescue_from ActionController::ParameterMissing do |e|
        expose_error(
          status: :bad_request,
          key: :PARAMETER_MISSING,
          message: e.message
        )
      end

      # jwt_auth
      rescue_from JwtAuth::Errors::MissingToken do |e|
        expose_error(
          status: :bad_request,
          key: :PARAMETER_MISSING,
          message: e.message
        )
      end

      rescue_from JwtAuth::Errors::InvalidToken do |e|
        expose_error(
          status: :unprocessable_entity,
          key: :BAD_PARAMETER,
          message: e.message
        )
      end

      rescue_from JwtAuth::Errors::Unauthorized do |e|
        expose_error(
          status: :unauthorized,
          key: :UNAUTHORIZED,
          message: e.message
        )
      end

      rescue_from JwtAuth::Errors::PermissionDenied do |e|
        expose_error(
          status: :forbidden,
          key: :PERMISSION_DENIED,
          message: e.message
        )
      end

      # using to raise errors
      rescue_from Errors::ServerError do |e|
        expose_error(
          status: :internal_server_error,
          key: :SERVER_ERROR,
          message: e.message
        )
      end

      rescue_from Errors::Unknown do |e|
        expose_error(
          status: :internal_server_error,
          key: :UNKNOWN,
          message: e.message
        )
      end

      rescue_from Errors::Unauthorized do |e|
        expose_error(
          status: :unauthorized,
          key: :UNAUTHORIZED,
          message: e.message
        )
      end

      rescue_from Errors::PermissionDenied do |e|
        expose_error(
          status: :forbidden,
          key: :PERMISSION_DENIED,
          message: e.message
        )
      end

      rescue_from Errors::BadParameter do |e|
        expose_error(
          status: :unprocessable_entity,
          key: :BAD_PARAMETER,
          message: e.message
        )
      end

      rescue_from Errors::ParameterMissing do |e|
        expose_error(
          status: :bad_request,
          key: :PARAMETER_MISSING,
          message: e.message
        )
      end

      rescue_from Errors::NotFound do |e|
        expose_error(
          status: :not_found,
          key: :NOT_FOUND,
          message: e.message
        )
      end

      rescue_from Errors::DataExisted do |e|
        expose_error(
          status: :bad_request,
          key: :DATA_EXISTED,
          message: e.message
        )
      end

      rescue_from Errors::InvalidCall do |e|
        expose_error(
          status: :bad_request,
          key: :INVALID_CALL,
          message: e.message
        )
      end

      rescue_from Errors::InvalidAccount do |e|
        expose_error(
          status: :forbidden,
          key: :INVALID_ACCOUNT,
          message: e.message
        )
      end

      rescue_from Errors::ActionAlreadyTaken do |e|
        expose_error(
          status: :bad_request,
          key: :ACTION_ALREADY_TAKEN,
          message: e.message
        )
      end
    end
  end
end
