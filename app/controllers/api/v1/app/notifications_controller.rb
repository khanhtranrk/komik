# frozen_string_literal: true

class Api::V1::App::NotificationsController < ApplicationController
  def index
    notificaitons = @current_user.notifications
                                 .order(created_at: :desc)

    paginate notificaitons,
             each_serializer: App::NotificationsSerializer
  end
end
