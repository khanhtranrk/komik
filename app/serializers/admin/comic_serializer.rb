# frozen_string_literal: true

class Admin::ComicSerializer < ActiveModel::Serializer
  include ImageUrlHelper

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
    make_image_url(@instance_options[:base_url], object.image)
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
