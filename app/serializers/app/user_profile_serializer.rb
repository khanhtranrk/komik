class App::UserProfileSerializer < ActiveModel::Serializer
  attributes :firstname,
             :lastname,
             :birthday,
             :email,
             :username,
             :image
end
