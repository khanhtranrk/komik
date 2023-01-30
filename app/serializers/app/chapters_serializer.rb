# frozen_string_literal: true

class App::ChaptersSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :posted_at,
             :free
end
