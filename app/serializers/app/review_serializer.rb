# frozen_string_literal: true

class App::ReviewSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :created_at,
             :updated_at
end

