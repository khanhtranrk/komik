# frozen_string_literal: true

class Api::V1::App::ChaptersController < ApplicationController
  before_action :set_comic

  def index
    chapters = Chapter.where(comic_id: @comic.id)

    paginate chapters,
             each_serializer: App::ChaptersSerializer,
             base_url: request.base_url
  end

  def show
    chapter = @comic.chapters
                    .includes(images_attachments: :blob)
                    .find(params[:id])

    raise Errors::PermissionDenied, t(:permission_denied) if !chapter.free && @current_user.current_plan.nil?

    reading_chapter = ReadingChapter.find_by(user_id: @current_user.id, comic_id: chapter.comic_id)

    if reading_chapter
      reading_chapter.update!(chapter_id: chapter.id)
    else
      ReadingChapter.create!(user_id: @current_user.id, comic_id: chapter.comic_id, chapter_id: chapter.id)
      chapter.comic.update!(views: chapter.comic.views + 1)
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
