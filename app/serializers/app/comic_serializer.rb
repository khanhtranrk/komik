# frozen_string_literal: true

class App::ComicSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :status,
             :views,
             :likes,
             :description,
             :image,
             :categories,
             :chapters

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::CategoriesSerializer
    )
  end

  def chapters
    ActiveModelSerializers::SerializableResource.new(
      object.chapters,
      each_serializer: App::ChaptersSerializer
    )
  end
end
