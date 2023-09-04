# frozen_string_literal: true

class Admin::ComicsSerializer < ActiveModel::Serializer
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
             :release_date,
             :image_url,
             :up_coming

  def image_url
    make_image_url(@instance_options[:base_url], object.image)
  end

  def up_coming
    object.last_updated_chapter_at.nil?
  end

  def authors
    ActiveModelSerializers::SerializableResource.new(
      object.authors,
      each_serializer: App::AuthorsSerializer
    )
  end
end
