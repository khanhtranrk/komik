class Api::V1::App::UsersController < ApplicationController
  def show
    expose @current_user,
           serializer: App::UserProfileSerializer
  end

  def update
    @current_user.update!(user_params)

    expose
  end

  def change_login_info
    raise Errors::BadParameter, t(:wrong_password) unless @current_user.authenticate(login_info_params[:password]);

    @current_user.update!(
      login_info_params.merge(password: login_info_params[:new_password])
                       .except(:new_password)
    )

    expose
  end

  private

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
