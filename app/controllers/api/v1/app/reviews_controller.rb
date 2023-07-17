# frozen_string_literal: true

class Api::V1::App::ReviewsController < ApplicationController
  before_action :set_comic
  before_action :set_review, except: %i[index create user_review]

  def index
    paginate @comic.reviews,
             each_serializer: App::ReviewsSerializer,
             base_url: request.base_url
  end

  def user_review
    review = Review.find_by(user: @current_user, comic: @comic)

    expose review,
           serializer: App::ReviewsSerializer,
           base_url: request.base_url
  end

  def create
    Review.create! review_params.merge(user: @current_user, comic: @comic)

    expose
  end

  def update
    @review.update! review_params

    expose
  end

  def destroy
    @review.destroy!
  end

  private

  def set_comic
    @comic = Comic.find_by!(id: params[:comic_id], active: true)
  end

  def set_review
    @review = @comic.reviews.find_by!(id: params[:id], user: @current_user)
  end

  def review_params
    params.require(:review)
          .permit :title,
                  :content
  end
end
