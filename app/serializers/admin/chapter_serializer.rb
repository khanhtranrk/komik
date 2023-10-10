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
    make_image_urls(@instance_options[:base_url], object.images)
  end
end
