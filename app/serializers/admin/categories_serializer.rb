# frozen_string_literal: true

class Admin::CategoriesSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description
end
