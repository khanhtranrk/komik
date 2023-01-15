# frozen_string_literal: true

class App::Categories::ManySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description
end
