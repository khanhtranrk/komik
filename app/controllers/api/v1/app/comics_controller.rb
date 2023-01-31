# frozen_string_literal: true

class Api::V1::App::ComicsController < ApplicationController
  before_action :set_comic, except: %i[index show]

  def index
    comics = Comic.filter(params)

    paginate comics,
             each_serializer: App::ComicsSerializer
  end

  def show
    commic = Comic.includes(:categories, :chapters)
                  .find(params[:id])

    expose commic,
           serializer: App::ComicSerializer,
           current_user: @current_user
  end

  def like
    Like.create(comic: @comic, user: @current_user)

    expose
  end

  def unlike
    Like.find_by!(comic: @comic, user: @current_user)
        .destroy

    expose
  end

  def follow
    Follow.create(comic: @comic, user: @current_user)

    expose
  end

  def unfollow
    Follow.find_by!(comic: @comic, user: @current_user)
          .destroy

    expose
  end

  private

  def set_comic
    @comic = Comic.find(params[:id])
  end
end
