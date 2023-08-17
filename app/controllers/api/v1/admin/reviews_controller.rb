# frozen_string_literal: true

class Api::V1::Admin::ReviewsController < AdministratorController
  before_action :set_comic
  before_action :set_review, except: %i[index]

  def index
    paginate @comic.reviews.include_evaluate_statistic(@current_user.id),
             each_serializer: Admin::ReviewsSerializer,
             base_url: request.base_url
  end

  def destroy
    @review.destroy!

    expose
  end

  private

  def set_comic
    @comic = Comic.find_by!(id: params[:comic_id])
  end

  def set_review
    @review = @comic.reviews.find_by!(id: params[:id])
  end
end
