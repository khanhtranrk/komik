# frozen_string_literal: true

class Api::V1::App::PlansController < ApplicationController
  def index
    expose Plan.all,
           each_serializer: App::PlansSerializer
  end
end
