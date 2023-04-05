# frozen_string_literal: true

class Admin::PlansSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :price,
             :value
end
