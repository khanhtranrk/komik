# frozen_string_literal: true

class Api::V1::App::CategoriesController < ApplicationController
  def index
    expose Category.all,
           each_serializer: App::Categories::ManySerializer
  end
end
