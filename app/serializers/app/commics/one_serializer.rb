# frozen_string_literal: true

class App::Commics::OneSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :status,
             :views,
             :likes,
             :description,
             :categories,
             :chapters

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::Categories::ManySerializer
    )
  end

  def chapters
    ActiveModelSerializers::SerializableResource.new(
      object.chapters,
      each_serializer: App::Chapters::ManySerializer
    )
  end
end
