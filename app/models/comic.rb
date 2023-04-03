# frozen_string_literal: true

class Comic < ApplicationRecord
  has_one_attached :image

  has_many :comics_categories, dependent: :delete_all
  has_many :categories, through: :comics_categories
  has_many :chapters, dependent: :delete_all
  has_many :reading_chapters, dependent: :delete_all

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

      if params[:category_ids].present?
        category_ids = params[:category_ids].split(',').map(&:to_i)
        comics = comics.left_joins(:comics_categories).where(comics_categories: { category_id: category_ids })
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
        sort_by = sort_by.select { |t| t[0].in?(%w[views likes updated_at last_updated_chapter_at]) && t[1].in?(%w[asc desc]) }
        sort_by = sort_by.map { |t| "comics.#{t[0]} #{t[1]}" }

        comics = comics.order(sort_by.join(', '))
      end

      comics
    end
  end
end
