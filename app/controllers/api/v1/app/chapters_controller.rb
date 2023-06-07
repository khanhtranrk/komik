# frozen_string_literal: true

class Api::V1::App::ChaptersController < ApplicationController
  def show
    chapter = Chapter.includes(images_attachments: :blob).find(params[:id])

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
    previous_chapter = current_chapter_index > 0 ? chapters[current_chapter_index - 1] : nil

    expose chapter,
           serializer: App::ChapterSerializer,
           base_url: request.base_url,
           next_chapter: next_chapter,
           previous_chapter: previous_chapter
  end
end
