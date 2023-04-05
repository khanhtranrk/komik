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

    expose chapter,
           serializer: App::ChapterSerializer,
           base_url: request.base_url
  end
end
