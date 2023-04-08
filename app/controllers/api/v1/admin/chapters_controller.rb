# frozen_string_literal: true

class Api::V1::Admin::ChaptersController < AdministratorController
  before_action :set_comic
  before_action :set_chapter, except: %i[index create]

  def index
    chapters = Chapter.where(comic_id: @comic.id)

    paginate chapters,
             each_serializer: Admin::ChaptersSerializer,
             base_url: request.base_url
  end

  def show
    expose @chapter,
           serializer: Admin::ChapterSerializer,
           base_url: request.base_url
  end

  def create
    Chapter.create!(chapter_params.merge(comic_id: @comic.id))

    @comic.update!(last_updated_chapter_at: Time.zone.now)

    @comic.users_followed.send_notification(
      Noti::Message.new(
        template: 'comic.followed',
        comic_name: @comic.name
      ).as_json
    )

    expose
  end

  def update
    @chapter.update!(chapter_params)

    expose
  end

  def destroy
    @chapter.destroy!

    expose
  end

  def upload_images
    @chapter.update!(upload_images_params)

    expose
  end

  private

  def set_comic
    @comic = Comic.find(params[:comic_id])
  end

  def set_chapter
    @chapter = Chapter.find(params[:id])
  end

  def upload_images_params
    params.permit images: []
  end

  def chapter_params
    params.require(:chapter)
          .permit :name,
                  :free
  end
end
