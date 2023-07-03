# frozen_string_literal: true

class App::AuthorsSerializer < ActiveModel::Serializer
  attributes :id,
             :firstname,
             :lastname
end
