# frozen_string_literal: true

class Api::V1::Admin::AuthorsController < AdministratorController
  before_action :set_author, except: %i[index create]

  def index
    authors = Author.filter(params)
                    .with_attached_image

    paginate authors,
             each_serializer: Admin::AuthorSerializer,
             base_url: request.base_url
  end

  def show
    expose @author,
           serializer: Admin::AuthorSerializer,
           base_url: request.base_url
  end

  def create
    Author.create!(chapter_params)

    expose
  end

  def update
    @author.update!(chapter_params)

    expose
  end

  def destroy
    @author.destroy!

    expose
  end

  def upload_image
    @author.update!(upload_image_params)

    expose
  end

  private

  def chapter_params
    params.require(:author)
          .permit :firstname,
                  :lastname,
                  :birthday,
                  :introduction
  end

  def set_author
    @author = Author.find(params[:id])
  end

  def upload_image_params
    params.permit :image
  end
end
