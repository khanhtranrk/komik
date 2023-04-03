# frozen_string_literal: true

class Admin::ChapterSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :posted_at,
             :free,
             :image_urls

  def image_urls
    object.images.map do |image|
      @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
    end
  end
end
