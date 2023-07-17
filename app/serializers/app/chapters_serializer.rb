# frozen_string_literal: true

class App::ChaptersSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :free,
             :created_at,
             :updated_at
end
