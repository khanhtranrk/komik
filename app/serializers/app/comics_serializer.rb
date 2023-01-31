# frozen_string_literal: true

class App::ComicsSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :status,
             :views,
             :likes,
             :description,
             :image

  def likes
    0
  end
end
