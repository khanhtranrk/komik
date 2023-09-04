# frozen_string_literal: true

class Admin::ChapterSerializer < ActiveModel::Serializer
  include ImageUrlHelper

  attributes :id,
             :name,
             :free,
             :image_urls,
             :created_at,
             :updated_at

  def image_urls
    object.images.map do |image|
      make_image_url(@instance_options[:base_url], image)
    end
  end
end
