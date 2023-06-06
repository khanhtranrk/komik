# frozen_string_literal: true

class Api::V1::AuthController < ApplicationController
  include JwtAuth::Helpers
  include VerificationHelper

  skip_before_action :authenticate!

  def sign_up
    user = User.create!(user_params.merge!(role: 0, birthday: '2001-01-01', locked: false))

    login = login!(user)

    update_login_device!(login)

    expose refresh_token: login.token,
           access_token: login.access_token,
           role: user.role
  end

  def sign_in
    user = User.find_by('username = ? or email = ?', params[:username_or_email], params[:username_or_email])

    raise Errors::BadParameter, t(:invalid_sign_in_info) unless user&.authenticate(params[:password])

    raise Errors::BadParameter, t(:account_locked) if user.locked

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
    return unless request.headers['Exponent-Token']

    Device.where(
      'exponent_token = ? or login_id = ?',
      request.headers['Exponent-Token'],
      login.id
    ).delete_all

    Device.create!(
      exponent_token: request.headers['Exponent-Token'],
      login_id: login.id
    )
  end

  def user_params
    params.permit(User::REQUIRED_ATTRIBUTES)
  end
end
