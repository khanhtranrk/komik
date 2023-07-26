# frozen_string_literal: true

class Reading < ApplicationRecord
  belongs_to :user
  belongs_to :chapter

  after_create :increate_comic_views
  after_destroy :decreate_comic_views

  private

  def increate_comic_views
    chapter.comic.update(views: chapter.comic.views + 1)
  end

  def decreate_comic_views
    chapter.comic.update(views: chapter.comic.views - 1)
  end
end
