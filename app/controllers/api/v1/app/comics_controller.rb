# frozen_string_literal: true

class Api::V1::App::ComicsController < ApplicationController
  def index
    paginate Comic.filter(params).includes(:image),
             each_serializer: App::Comics::ManySerializer
  end

  def show
    commic = Comic.includes(:categories, :chapters)
                  .find(params[:id])

    expose commic,
           serializer: App::Comics::OneSerializer
  end
end
