# frozen_string_literal: true

class Comic < ApplicationRecord
  has_one_attached :image

  has_many :comics_categories, dependent: :delete_all
  has_many :categories, through: :comics_categories
  has_many :chapters, dependent: :delete_all
  has_many :reading_chapters, dependent: :delete_all
  has_many :favoritez, class_name: 'Favorite', inverse_of: :comic, dependent: :delete_all
  has_many :followz, class_name: 'Follow', inverse_of: :comic, dependent: :delete_all
  has_many :users_favorited, through: :favoritez, source: :user
  has_many :users_followed, through: :followz, source: :user
  has_many :review, dependent: :delete_all
  has_many :authors_comics, dependent: :delete_all
  has_many :authors, through: :authors_comics

  def author_names
    authors.pluck(:firstname).join(', ')
  end

  def liked_by?(user)
    Like.exists?(user:, comic_id: id)
  end

  def followed_by?(user)
    Follow.exists?(user:, comic_id: id)
  end

  def reading_chapter_by(user)
    reading_chapters.find_by(user:)
  end

  class << self
    def filter(params)
      comics = all

      if params[:release_dates].present?
        release_dates = params[:category_ids].split(',').map(&:to_i)
        comic_ids = ComicsCategory.where(release_date: category_ids).pluck(:comic_id)
        comics = comics.where(id: comic_ids)
      end

      if params[:category_ids].present?
        category_ids = params[:category_ids].split(',').map(&:to_i)
        comic_ids = ComicsCategory.where(category_id: category_ids).pluck(:comic_id)
        comics = comics.where(id: comic_ids)
      end

      if params[:query].present?
        query = params[:query].strip

        comics = comics.where(
          'name ILIKE ? OR other_names ILIKE ? OR description ILIKE ? OR author ILIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
        )
      end

      if params[:sort_by].present?
        sort_by = params[:sort_by].split(',').map { |t| t.split('-') }
        sort_by = sort_by.select { |t| t[0].in?(%w[views likes updated_at last_updated_chapter_at created_at]) && t[1].in?(%w[asc desc]) }
        sort_by = sort_by.map { |t| "comics.#{t[0]} #{t[1]}" }

        comics = comics.order(sort_by.join(', '))
      end

      comics
    end
  end
end
