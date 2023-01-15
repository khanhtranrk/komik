# frozen_string_literal: true

class Api::V1::App::CommicsController < ApplicationController
  def index
    paginate Commic.all,
             each_serializer: App::Commics::ManySerializer
  end

  def show
    commic = Commic.includes(:categories, :chapters)
                   .find(params[:id])

    expose commic,
           serializer: App::Commics::OneSerializer
  end
end
