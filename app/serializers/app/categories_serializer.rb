# frozen_string_literal: true

class App::CategoriesSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description
end
