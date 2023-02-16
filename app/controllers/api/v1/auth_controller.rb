# frozen_string_literal: true

class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate!, except: %i[sign_out]

  include JwtAuth::Helpers

  def sign_up
    user = User.create!(user_params.merge!(role: 1, birthday: '2001-01-01'))

    login = login!(user)

    update_login_device!(login)

    expose refresh_token: login.token,
           access_token: login.access_token
  end

  def sign_in
    user = User.find_by!('username = ? or email = ?', params[:username_or_email], params[:username_or_email])

    raise Errors::Unauthorized, t(:invalid_sign_in_info) unless user&.authenticate(params[:password])

    login = login!(user)

    update_login_device!(login)

    expose refresh_token: login.token,
           access_token: login.access_token
  end

  def sign_out
    logout!
    expose
  end

  def refresh
    login = refresh!

    update_login_device!(login)

    expose refresh_token: login.token,
           access_token: login.access_token
  end

  private

  def update_login_device!(login)
    if request.headers['Exponent-Token']
      Device.upsert({login_id: login.id, exponent_token: request.headers['Exponent-Token']}, unique_by: %i[exponent_token])
    else
      device = login.device
      device.destroy! if device
    end
  end

  def user_params
    params.permit(User::REQUIRED_ATTRIBUTES)
  end
end
