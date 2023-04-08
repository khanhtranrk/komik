# frozen_string_literal: true

class Api::V1::App::CategoriesController < ApplicationController
  def index
    expose Category.all.order(name: :asc),
           each_serializer: App::CategoriesSerializer
  end
end
