# frozen_string_literal: true

class App::UserProfileSerializer < ActiveModel::Serializer
  include ImageUrlHelper

  attributes :firstname,
             :lastname,
             :birthday,
             :email,
             :username,
             :avatar_url,
             :current_plan

  def avatar_url
    make_image_url(@instance_options[:base_url], object.avatar)
  end

  def current_plan
    purchase = object.current_plan

    return nil if purchase.nil?

    ActiveModelSerializers::SerializableResource.new(
      object.current_plan,
      each_serializer: App::PurchaseSerializer
    )
  end
end
