# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :comic

  validates :user, uniqueness: { scope: %i[comic_id] }

  after_create :increate_comic_followers
  after_destroy :decreate_comic_followers

  private

  def increate_comic_followers
    comic.update(follows: comic.follows + 1)
  end

  def decreate_comic_followers
    comic.update(follows: comic.follows - 1)
  end
end
