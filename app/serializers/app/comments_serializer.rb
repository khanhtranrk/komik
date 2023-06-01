# frozen_string_literal: true

class App::CommentsSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content
end
