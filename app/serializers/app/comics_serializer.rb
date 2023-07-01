# frozen_string_literal: true

class App::ComicsSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :author_names,
             :status,
             :views,
             :likes,
             :description,
             :image_url,
             :up_coming

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def up_coming
    object.last_updated_chapter_at.nil?
  end
end
