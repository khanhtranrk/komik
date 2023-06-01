# frozen_string_literal: true

class Api::V1::App::CommentsController < ApplicationController
  before_action :set_comic
  before_action :set_comment, except: %i[index create]

  def index
    paginate @comic.comments,
             each_serializer: App::CommentsSerializer
  end

  def create
    Comment.create! comment_params.merge(user: @current_user, comic: @comic)

    expose
  end

  def update
    @comment.update! comment_params

    expose
  end

  def destroy
    @comment.destroy!
  end

  private

  def set_comic
    @comic = Comic.find_by!(id: params[:comic_id], active: true)
  end

  def set_comment
    @comment = @comic.comments.find_by!(id: params[:id], user: @current_user)
  end

  def comment_params
    params.require(:comment)
          .permit :title,
                  :content
  end
end
