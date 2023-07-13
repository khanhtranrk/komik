# frozen_string_literal: true

class Api::V1::App::AuthorsController < ApplicationController
  before_action :set_author

  def show
    expose @author,
           serializer: App::AuthorSerializer,
           base_url: request.base_url
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end
end
