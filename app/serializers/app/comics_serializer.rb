# frozen_string_literal: true

class App::ComicsSerializer < ActiveModel::Serializer
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
             :up_coming

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def up_coming
    object.last_updated_chapter_at.nil?
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::CategoriesSerializer
    )
  end

  def authors
    ActiveModelSerializers::SerializableResource.new(
      object.authors,
      each_serializer: App::AuthorsSerializer
    )
  end
end
