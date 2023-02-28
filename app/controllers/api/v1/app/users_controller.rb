# frozen_string_literal: true

class Api::V1::App::UsersController < ApplicationController
  def show
    expose @current_user,
           serializer: App::UserProfileSerializer,
           base_url: request.base_url
  end

  def update
    @current_user.update!(user_params)

    expose @current_user,
           serializer: App::UserProfileSerializer,
           base_url: request.base_url
  end

  def upload_avatar
    @current_user.update!(upload_avatar_params)

    expose @current_user,
           serializer: App::UserProfileSerializer,
           base_url: request.base_url
  end

  def change_login_info
    raise Errors::BadParameter, t(:wrong_password) unless @current_user.authenticate(login_info_params[:password])

    if login_info_params[:new_password]
      @current_user.update!(
        login_info_params.merge(password: login_info_params[:new_password])
                         .except(:new_password)
      )
    else
      @current_user.update!(
        login_info_params.except(:new_password, :password)
      )
    end

    expose @current_user,
           serializer: App::UserProfileSerializer,
           base_url: request.base_url
  end

  private

  def upload_avatar_params
    params.permit(:avatar)
  end

  def user_params
    params.require(:user)
          .permit :firstname,
                  :lastname,
                  :birthday
  end

  def login_info_params
    params.require(:user)
          .permit :email,
                  :username,
                  :new_password,
                  :password
  end
end
