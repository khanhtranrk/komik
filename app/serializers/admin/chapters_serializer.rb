# frozen_string_literal: true

class Admin::ChaptersSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :posted_at,
             :free
end
