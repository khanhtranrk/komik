# frozen_string_literal: true

class Api::V1::App::ReviewsController < ApplicationController
  before_action :set_comic
  before_action :set_review, except: %i[index create user_review]

  def index
    paginate @comic.reviews.include_evaluate_statistic(@current_user.id),
             each_serializer: App::ReviewsSerializer,
             base_url: request.base_url
  end

  def user_review
    review = Review.find_by(user: @current_user, comic: @comic)

    expose review,
           serializer: App::ReviewSerializer,
           base_url: request.base_url
  end

  def create
    Review.create! review_params.merge(user: @current_user, comic: @comic)

    expose
  end

  def update
    @review.update! review_params
    @review.evaluates.delete_all

    expose
  end

  def destroy
    @review.destroy!
  end

  def evaluate
    point_of_view = evaluate_params[:point_of_view]

    eva = Evaluate.find_by(user: @current_user, review: @review)

    if eva.present?
      if eva.point_of_view.eql?(Evaluate.point_of_views.key(point_of_view))
        eva.destroy!
      else
        eva.update!(point_of_view: point_of_view)
      end
    else
      Evaluate.create!(user: @current_user, review: @review, point_of_view: point_of_view)
    end

    expose
  end

  private

  def evaluate_params
    params.require(:evaluate)
          .permit :point_of_view
  end

  def set_comic
    @comic = Comic.find_by!(id: params[:comic_id], active: true)
  end

  def set_review
    @review = @comic.reviews.find_by!(id: params[:id])
  end

  def review_params
    params.require(:review)
          .permit :title,
                  :content
  end
end
