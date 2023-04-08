# frozen_string_literal: true

class Admin::ComicSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :status,
             :views,
             :likes,
             :active,
             :description,
             :categories,
             :image_url

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::CategoriesSerializer
    )
  end
end
