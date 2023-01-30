# frozen_string_literal: true

class App::UserProfileSerializer < ActiveModel::Serializer
  attributes :firstname,
             :lastname,
             :birthday,
             :email,
             :username,
             :image
end
