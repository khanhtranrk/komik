# frozen_string_literal: true

class App::ComicsSerializer < ActiveModel::Serializer
  include ImageUrlHelper

  attributes :id,
             :name,
             :other_names,
             :authors,
             :categories,
             :status,
             :views,
             :favorites,
             :follows,
             :description,
             :release_date,
             :image_url,
             :up_coming,
             :last_updated_chapter_at

  attribute :last_read_at, if: -> { object.has_attribute?(:last_read_at) }
  attribute :new_chapters, if: -> { object.has_attribute?(:new_chapters) }

  def image_url
    make_image_url(@instance_options[:base_url], object.image)
  end

  def up_coming
    object.last_updated_chapter_at.nil?
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::CategoriesSerializer,
    ).as_json
  end

  def authors
    ActiveModelSerializers::SerializableResource.new(
      object.authors,
      each_serializer: App::AuthorsSerializer
    ).as_json
  end
end
