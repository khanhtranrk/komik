# frozen_string_literal: true

class App::ChaptersSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :free,
             :read,
             :created_at,
             :updated_at
end
