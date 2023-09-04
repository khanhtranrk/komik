# frozen_string_literal: true

class App::UserSerializer < ActiveModel::Serializer
  include ImageUrlHelper

  attributes :username,
             :firstname,
             :lastname,
             :avatar_url

  def avatar_url
    make_image_url(@instance_options[:base_url], object.avatar)
  end
end
