# frozen_string_literal: true

class App::Chapters::OneSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :posted_at,
             :free,
             :images

  def images
    ActiveModelSerializers::SerializableResource.new(
      object.images,
      each_serializer: App::Images::SelfSerializer
    )
  end
end
