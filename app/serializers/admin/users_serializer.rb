# frozen_string_literal: true

class Admin::UsersSerializer < ActiveModel::Serializer
  attributes :username,
             :email,
             :firstname,
             :lastname,
             :birthday,
             :role,
             :avatar_url,
             :locked

  def avatar_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true) if object.avatar.attached?
  end
end
