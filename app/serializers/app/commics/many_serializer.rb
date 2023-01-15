# frozen_string_literal: true

class App::Commics::ManySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :status,
             :views,
             :likes,
             :description
end
