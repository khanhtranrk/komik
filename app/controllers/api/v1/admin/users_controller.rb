# frozen_string_literal: true

class Api::V1::Admin::UsersController < AdministratorController
  before_action :set_user, except: %i[index create]

  def index
    users = User.filter(params)
                .where('id != ?', @current_user.id)
                .with_attached_avatar

    paginate users,
             each_serializer: Admin::UsersSerializer,
             base_url: request.base_url
  end

  def show
    expose @user,
           serializer: Admin::UsersSerializer,
           base_url: request.base_url
  end

  def create
    full_params = user_params.merge(locked: false)
    full_params[:username] = full_params[:username].downcase if full_params[:username]
    full_params[:email] = full_params[:email].downcase if full_params[:email]

    User.create!(full_params)

    expose
  end

  def update
    @user.update!(user_params_updatable)

    expose
  end

  private

  def user_params
    params.require(:user)
          .permit :username,
                  :email,
                  :password,
                  :role,
                  :birthday,
                  :firstname,
                  :lastname
  end

  def user_params_updatable
    params.require(:user)
          .permit :role,
                  :locked
  end

  def set_user
    @user = User.find_by!(username: params[:id])
  end
end
