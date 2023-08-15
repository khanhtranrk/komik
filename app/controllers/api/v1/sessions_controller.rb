# frozen_string_literal: true

class Api::V1::SessionsController < ApplicationController
  include JwtAuth::Helpers
  include VerificationHelper

  skip_before_action :authenticate!

  def sign_up
    full_params = user_params.merge!(role: 0, birthday: '2001-01-01')
    full_params[:username] = full_params[:username].downcase if full_params[:username]
    full_params[:email] = full_params[:email].downcase if full_params[:email]

    user = User.create!(full_params)

    session = login!(user)

    expose refresh_token: session.refresh_token,
           access_token: session.access_token,
           role: user.role
  end

  def sign_in
    user = User.find_by('username = ? or email = ?', params[:username_or_email].downcase, params[:username_or_email].downcase)

    raise Errors::BadParameter, t(:invalid_sign_in_info) unless user&.authenticate(params[:password])

    raise Errors::BadParameter, t(:account_locked) if user.locked

    session = login!(user)

    expose refresh_token: session.refresh_token,
           access_token: session.access_token,
           role: user.role
  end

  def sign_out
    logout!
    expose
  end

  def refresh
    session = refresh!

    expose refresh_token: session.refresh_token,
           access_token: session.access_token,
           role: session.user.role
  end

  def send_verification_code
    user = User.find_by(email: params[:email].downcase)
    raise Errors::BadParameter, t(:email_not_found) unless user

    send_verification_code_to(user)

    expose
  end

  def reset_password
    user = User.find_by(email: params[:email].downcase)
    raise Errors::BadParameter, t(:verification_code_invalid) unless verification_code_valid?(user, params[:verification_code])

    user.update!(password: params[:password])

    expose
  end

  private

  def user_params
    params.permit(User::REQUIRED_ATTRIBUTES)
  end
end
