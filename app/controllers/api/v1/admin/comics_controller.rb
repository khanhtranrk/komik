# frozen_string_literal: true

class Api::V1::Admin::ComicsController < AdministratorController
  before_action :set_comic, except: %i[index create show]

  def index
    comics = Comic.filter(params)

    paginate comics,
             each_serializer: Admin::ComicsSerializer,
             base_url: request.base_url
  end

  def show
    comic = Comic.includes(:categories, :chapters)
                 .find(params[:id])

    expose comic,
           serializer: Admin::ComicSerializer,
           current_user: @current_user,
           base_url: request.base_url
  end

  def create
    Comic.create!(comic_params)

    expose
  end

  def update
    @comic.update!(comic_params)

    expose
  end

  def destroy
    @comic.destroy!

    expose
  end

  def upload_image
    @comic.update!(upload_image_params)

    expose
  end

  private

  def upload_image_params
    params.permit :image
  end

  def set_comic
    @comic = Comic.find(params[:id])
  end

  def comic_params
    params.require(:comic)
          .permit :name,
                  :other_names,
                  :author,
                  :status,
                  :description,
                  category_ids: []
  end
end
