# frozen_string_literal: true

class Admin::ComicSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :authors,
             :status,
             :views,
             :favorites,
             :follows,
             :active,
             :description,
             :categories,
             :release_date,
             :image_url

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: Admin::CategoriesSerializer
    )
  end

  def authors
    ActiveModelSerializers::SerializableResource.new(
      object.authors.with_attached_image,
      base_url: @instance_options[:base_url],
      each_serializer: Admin::AuthorsSerializer
    )
  end
end
