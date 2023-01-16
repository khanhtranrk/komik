# frozen_string_literal: true

class App::Comics::ManySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :status,
             :views,
             :likes,
             :description,
             :image_url
end
