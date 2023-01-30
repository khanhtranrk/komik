# frozen_string_literal: true

class App::ChapterSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :posted_at,
             :free,
             :images

  def images
    ActiveModelSerializers::SerializableResource.new(
      object.images,
      each_serializer: App::ImageSerializer
    )
  end
end
