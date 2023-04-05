# frozen_string_literal: true

class Api::V1::App::ComicsController < ApplicationController
  before_action :set_comic, except: %i[index show liked followed read]

  def index
    comics = Comic.filter(params)

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  def show
    comic = Comic.includes(:categories, :chapters)
                 .find(params[:id])

    expose comic,
           serializer: App::ComicSerializer,
           current_user: @current_user,
           base_url: request.base_url
  end

  def like
    Like.create!(comic: @comic, user: @current_user)

    @comic.update(likes: @comic.likes + 1)

    expose
  end

  def unlike
    Like.find_by!(comic: @comic, user: @current_user)
        .destroy!

    @comic.update(likes: @comic.likes - 1)

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

  def liked
    comics = Comic.where(id: @current_user.likes.pluck(:comic_id))

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  def followed
    comics = Comic.where(id: @current_user.follows.pluck(:comic_id))

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  def read
    comics = Comic.where(id: @current_user.reading_chapters.pluck(:comic_id))
                  .order(updated_at: :desc)

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  private

  def set_comic
    @comic = Comic.find(params[:id])
  end
end
