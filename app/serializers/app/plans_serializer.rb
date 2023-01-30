# frozen_string_literal: true

class App::PlansSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :price,
             :value
end
