# frozen_string_literal: true

class App::ChapterSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :posted_at,
             :free,
             :image_urls,
             :next_chapter,
             :previous_chapter

  def image_urls
    object.images.map do |image|
      @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
    end
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
