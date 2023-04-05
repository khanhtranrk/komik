# frozen_string_literal: true

class Api::V1::AuthController < ApplicationController
  include JwtAuth::Helpers
  include VerificationHelper

  skip_before_action :authenticate!

  def sign_up
    user = User.create!(user_params.merge!(role: 0, birthday: '2001-01-01'))

    login = login!(user)

    update_login_device!(login)

    expose refresh_token: login.token,
           access_token: login.access_token,
           role: user.role
  end

  def sign_in
    user = User.find_by('username = ? or email = ?', params[:username_or_email], params[:username_or_email])

    raise Errors::BadParameter, t(:invalid_sign_in_info) unless user&.authenticate(params[:password])

    login = login!(user)

    update_login_device!(login)

    expose refresh_token: login.token,
           access_token: login.access_token,
           role: user.role
  end

  def sign_out
    logout!
    expose
  end

  def refresh
    login = refresh!

    update_login_device!(login)

    expose refresh_token: login.token,
           access_token: login.access_token,
           role: login.user.role
  end

  def send_verification_code
    user = User.find_by(email: params[:email])
    raise Errors::BadParameter, t(:email_not_found) unless user

    send_verification_code_to(user)

    expose
  end

  def reset_password
    user = User.find_by(email: params[:email])
    raise Errors::BadParameter, t(:verification_code_invalid) unless verification_code_valid?(user, params[:verification_code])

    user.update!(password: params[:password])

    expose
  end

  private

  def update_login_device!(login)
    if login.device.present?
      login.device.update!(exponent_token: request.headers['Exponent-Token'])
    else
      Device.create!(login_id: login.id, exponent_token: request.headers['Exponent-Token'])
    end
  end

  def user_params
    params.permit(User::REQUIRED_ATTRIBUTES)
  end
end
