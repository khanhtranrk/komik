# frozen_string_literal: true

class Api::V1::App::FeedbacksController < ApplicationController
  def create
    Feedback.create!(feedback_params.merge(user_id: @current_user.id))

    # send notify
    Notify::PushJob.perform_later(
      @current_user,
      Noti::Message.new(
        template: 'feedback.thank'
      ).as_json
    )

    expose
  end

  private

  def feedback_params
    params.require(:feedback)
          .permit(:title, :content)
  end
end
