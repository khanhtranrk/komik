# frozen_string_literal: true

class App::ComicSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :other_names,
             :author,
             :status,
             :views,
             :likes,
             :description,
             :image,
             :categories,
             :chapters

  attribute :liked, if: :current_user?
  attribute :followed, if: :current_user?
  attribute :reading_chapter, if: :current_user?

  def current_user?
    @instance_options[:current_user].present?
  end

  def liked
    object.liked_by?(@instance_options[:current_user])
  end

  def followed
    object.followed_by?(@instance_options[:current_user])
  end

  def reading_chapter
    ActiveModelSerializers::SerializableResource.new(
      object.reading_chapter_by(@instance_options[:current_user]).chapter,
      each_serializer: App::ChaptersSerializer
    )
  rescue StandardError
    nil
  end

  def likes
    0
  end

  def categories
    ActiveModelSerializers::SerializableResource.new(
      object.categories,
      each_serializer: App::CategoriesSerializer
    )
  end

  def chapters
    ActiveModelSerializers::SerializableResource.new(
      object.chapters,
      each_serializer: App::ChaptersSerializer
    )
  end
end
