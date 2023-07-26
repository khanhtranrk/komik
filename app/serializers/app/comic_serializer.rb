# frozen_string_literal: true

class App::ComicSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :authors,
             :status,
             :views,
             :favorites,
             :follows,
             :description,
             :categories,
             :release_date,
             :image_url,
             :up_coming

  attribute :favorited, if: :current_user?
  attribute :followed, if: :current_user?
  attribute :reading_chapter, if: :current_user?

  def image_url
    @instance_options[:base_url] + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  def current_user?
    @instance_options[:current_user].present?
  end

  def up_coming
    object.last_updated_chapter_at.nil?
  end

  def favorited
    object.favorited_by?(@instance_options[:current_user])
  end

  def followed
    object.followed_by?(@instance_options[:current_user])
  end

  def reading_chapter
    ActiveModelSerializers::SerializableResource.new(
      object.reading_chapter_by(@instance_options[:current_user]).chapter.merge(read: true),
      each_serializer: App::ChaptersSerializer
    )
  rescue StandardError
    nil
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::CategoriesSerializer
    )
  end

  def authors
    ActiveModelSerializers::SerializableResource.new(
      object.authors,
      each_serializer: App::AuthorsSerializer
    )
  end
end
