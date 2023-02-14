# frozen_string_literal: true

class Api::V1::App::ChaptersController < ApplicationController
  def show
    chapter = Chapter.includes(:images)
                     .find(params[:id])

    raise Errors::PermissionDenied, t(:permission_denied) if !chapter.free && @current_user.current_plan.nil?

    # rubocop:disable Rails/SkipsModelValidations
    ReadingChapter.upsert(
      {
        chapter_id: chapter.id,
        user_id: @current_user.id,
        comic_id: chapter.comic_id
      },
      unique_by: %i[user_id comic_id]
    )
    # rubocop:enable Rails/SkipsModelValidations

    expose chapter,
           serializer: App::ChapterSerializer
  end
end
