# frozen_string_literal: true

class App::UserProfileSerializer < ActiveModel::Serializer
  attributes :firstname,
             :lastname,
             :birthday,
             :email,
             :username,
             :avatar_url

  def avatar_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true) if object.avatar.attached?
  end
end
