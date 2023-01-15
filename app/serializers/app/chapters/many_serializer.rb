# frozen_string_literal: true

class App::Chapters::ManySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :posted_at,
             :free
end
