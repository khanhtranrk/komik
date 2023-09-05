# frozen_string_literal: true

class App::ChapterSerializer < ActiveModel::Serializer
  include ImageUrlHelper

  attributes :id,
             :name,
             :free,
             :created_at,
             :updated_at,
             :image_urls,
             :next_chapter,
             :previous_chapter

  def image_urls
    make_image_urls(@instance_options[:base_url], object.images)
  end

  def next_chapter
    return nil if @instance_options[:next_chapter].nil?

    ActiveModelSerializers::SerializableResource.new(
      @instance_options[:next_chapter],
      serializer: App::ChaptersSerializer
    )
  end

  def previous_chapter
    return nil if @instance_options[:previous_chapter].nil?

    ActiveModelSerializers::SerializableResource.new(
      @instance_options[:previous_chapter],
      serializer: App::ChaptersSerializer
    )
  end
end
