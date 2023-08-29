# frozen_string_literal: true

module ErrorHandler
  module Rescuers
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        expose_error(
          status: :internal_server_error,
          message: I18n.t('error_handler.server_error'),
          errors: e
        )
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        expose_error(
          status: :not_found,
          message: I18n.t('error_handler.not_found'),
          errors: e
        )
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        expose_error(
          status: :unprocessable_entity,
          message: e.record.errors.full_messages.to_sentence,
          errors: e
        )
      end

      rescue_from ActionController::ParameterMissing do |e|
        expose_error(
          status: :bad_request,
          message: e.message,
          errors: e
        )
      end

      # jwt_auth
      rescue_from JwtAuth::Errors::MissingToken do |e|
        expose_error(
          status: :bad_request,
          message: e.message,
          errors: e
        )
      end

      rescue_from JwtAuth::Errors::InvalidToken do |e|
        expose_error(
          status: :unprocessable_entity,
          message: e.message,
          errors: e
        )
      end

      rescue_from JwtAuth::Errors::Unauthorized do |e|
        expose_error(
          status: :unauthorized,
          message: e.message,
          errors: e
        )
      end

      rescue_from JwtAuth::Errors::PermissionDenied do |e|
        expose_error(
          status: :forbidden,
          message: e.message,
          errors: e
        )
      end

      # using to raise errors
      rescue_from Errors::ServerError do |e|
        expose_error(
          status: :internal_server_error,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::Unknown do |e|
        expose_error(
          status: :internal_server_error,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::Unauthorized do |e|
        expose_error(
          status: :unauthorized,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::PermissionDenied do |e|
        expose_error(
          status: :forbidden,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::BadParameter do |e|
        expose_error(
          status: :unprocessable_entity,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::ParameterMissing do |e|
        expose_error(
          status: :bad_request,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::NotFound do |e|
        expose_error(
          status: :not_found,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::DataExisted do |e|
        expose_error(
          status: :bad_request,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::InvalidCall do |e|
        expose_error(
          status: :bad_request,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::InvalidAccount do |e|
        expose_error(
          status: :forbidden,
          message: e.message,
          errors: e
        )
      end

      rescue_from Errors::ActionAlreadyTaken do |e|
        expose_error(
          status: :bad_request,
          message: e.message,
          errors: e
        )
      end
    end
  end
end
