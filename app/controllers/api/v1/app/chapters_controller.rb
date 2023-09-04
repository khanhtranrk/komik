# frozen_string_literal: true

class Api::V1::App::ChaptersController < ApplicationController
  before_action :set_comic

  def index
    chapters = Chapter.select('chapters.*', 'BOOL_OR(CASE WHEN readings.id IS NOT NULL THEN true ELSE false END) AS read')
                      .joins("LEFT JOIN readings ON readings.chapter_id = chapters.id AND readings.user_id = #{@current_user.id}")
                      .group('chapters.id')
                      .where(comic_id: @comic.id)

    paginate chapters,
             each_serializer: App::ChaptersSerializer,
             base_url: request.base_url
  end

  def show
    chapter = @comic.chapters
                    .includes(images_attachments: :blob)
                    .find(params[:id])

    # Checking plan
    raise Errors::PermissionDenied, t(:permission_denied) if !chapter.free && @current_user.current_plan.nil?

    # Checking read
    reading = Reading.find_by(user_id: @current_user.id, chapter_id: chapter.id)

    if reading
      reading.update!(updated_at: Time.zone.now)
    else
      Reading.create!(user_id: @current_user.id, chapter_id: chapter.id)
    end

    chapters = chapter.comic.chapters
    current_chapter_index = chapters.index(chapter)
    next_chapter = current_chapter_index < chapters.size - 1 ? chapters[current_chapter_index + 1] : nil
    previous_chapter = current_chapter_index.positive? ? chapters[current_chapter_index - 1] : nil

    expose chapter,
           serializer: App::ChapterSerializer,
           base_url: request.base_url,
           next_chapter:,
           previous_chapter:
  end

  private

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end
end
