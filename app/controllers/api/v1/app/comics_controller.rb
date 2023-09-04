# frozen_string_literal: true

class Api::V1::App::ComicsController < ApplicationController
  before_action :set_comic, except: %i[index show favorited followed read]

  def index
    comics = Comic.filter(params)
                  .where(active: true)
                  .where('comics.last_updated_chapter_at IS NOT NULL')
                  .includes(:categories, :authors)
                  .with_attached_image

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  def show
    comic = Comic.includes(:categories, :chapters, :authors)
                 .find_by!(id: params[:id], active: true)

    expose comic,
           serializer: App::ComicSerializer,
           current_user: @current_user,
           base_url: request.base_url
  end

  def favorite
    Favorite.create!(comic: @comic, user: @current_user)

    expose
  end

  def unfavorite
    Favorite.find_by!(comic: @comic, user: @current_user)
            .destroy!

    expose
  end

  def follow
    Follow.create!(comic: @comic, user: @current_user)

    expose
  end

  def unfollow
    Follow.find_by!(comic: @comic, user: @current_user)
          .destroy

    expose
  end

  def favorited
    comics = Comic.where(id: @current_user.favorites.pluck(:comic_id), active: true)
                  .order(last_updated_chapter_at: :desc)

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  def followed
    comics = Comic.where(id: @current_user.follows.pluck(:comic_id), active: true)
                  .order(last_updated_chapter_at: :desc)

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  def up_coming
    comics = Comic.where(active: true, last_updated_chapter_at: nil)
                  .order(created_at: :desc)

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  def read
    comics = Comic.includes(:authors, :categories)
                  .with_attached_image
                  .where(active: true)
                  .reading_by(@current_user.id)

    paginate comics,
             each_serializer: App::ComicsSerializer,
             base_url: request.base_url
  end

  private

  def set_comic
    @comic = Comic.find_by(id: params[:id], active: true)
  end
end
