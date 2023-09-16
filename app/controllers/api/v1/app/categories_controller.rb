# frozen_string_literal: true

class Api::V1::App::CategoriesController < ApplicationController
  def index
    sara :categories do |options|
      options[:each_serializer] = App::CategoriesSerializer
      Category.all.order(name: :asc)
    end
  end
end
