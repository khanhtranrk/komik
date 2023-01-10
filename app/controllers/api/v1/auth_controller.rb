# frozen_string_literal: true

class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate!, except: %i[sign_out]

  include JwtAuth::Helpers

  def sign_up
    user = User.create!(user_params.merge!(role: 1))

    expose login!(user)
  end

  def sign_in
    user = User.find_by!(email: params[:email])

    raise Errors::Unauthorized, t(:invalid_sign_in_info) unless user&.authenticate(params[:password])

    expose login!(user)
  end

  def sign_out
    expose logout!
  end

  def refresh
    expose refresh!
  end

  private

  def user_params
    params.permit(User::REQUIRED_ATTRIBUTES)
  end
end
