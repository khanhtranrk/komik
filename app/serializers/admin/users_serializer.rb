# frozen_string_literal: true

class Admin::UsersSerializer < ActiveModel::Serializer
  include ImageUrlHelper

  attributes :username,
             :email,
             :firstname,
             :lastname,
             :birthday,
             :role,
             :avatar_url,
             :locked

  def avatar_url
    make_image_url(@instance_options[:base_url], object.avatar)
  end
end
