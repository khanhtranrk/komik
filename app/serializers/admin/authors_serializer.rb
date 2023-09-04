# frozen_string_literal: true

class Admin::AuthorsSerializer < ActiveModel::Serializer
  include ImageUrlHelper

  attributes :id,
             :firstname,
             :lastname,
             :birthday,
             :introduction,
             :image_url

  def image_url
    make_image_url(@instance_options[:base_url], object.image)
  end
end
