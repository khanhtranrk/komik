# frozen_string_literal: true

class Api::V1::Admin::FeedbacksController < AdministratorController
  def index
    feedbacks = Feedback.filter(params)

    paginate feedbacks,
             each_serializer: Admin::FeedbacksSerializer,
             base_url: request.base_url
  end
end
