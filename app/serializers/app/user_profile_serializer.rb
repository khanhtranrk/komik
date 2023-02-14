# frozen_string_literal: true

class App::UserProfileSerializer < ActiveModel::Serializer
  attributes :firstname,
             :lastname,
             :birthday,
             :email,
             :username,
             :avatar_url,
             :current_plan

  def avatar_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true) if object.avatar.attached?
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
