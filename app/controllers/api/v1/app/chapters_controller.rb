# frozen_string_literal: true

class Api::V1::App::ChaptersController < ApplicationController
  def show
    chapter = Chapter.includes(:images)
                     .find(params[:id])

    expose chapter,
           serializer: App::ChapterSerializer
  end
end
