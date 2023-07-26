# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :comic

  validates :user, uniqueness: { scope: %i[comic_id] }

  after_create :increate_comic_favorites
  after_destroy :decreate_comic_favorites

  private

  def increate_comic_favorites
    comic.update(favorites: comic.favorites + 1)
  end

  def decreate_comic_favorites
    comic.update(favorites: comic.favorites - 1)
  end
end
