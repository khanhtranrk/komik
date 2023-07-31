# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :comics_categories, dependent: :destroy
  has_many :comics, through: :comics_categories

  validates :name, uniqueness: true
  validates :name, presence: true

  class << self
    def filter(params)
      categories = all.order(id: :asc)

      if params[:query].present?
        query = params[:query].strip

        categories = categories.where('name ILIKE ?', "%#{query}%")
      end

      if params[:sort_by].present?
        sort_by = params[:sort_by].split(',').map { |t| t.split('-') }
        sort_by = sort_by.select { |t| t[0].in?(%w[name created_at]) && t[1].in?(%w[asc desc]) }
        sort_by = sort_by.map { |t| "categories.#{t[0]} #{t[1]}" }

        categories = categories.order(sort_by.join(', '))
      end

      categories
    end

    def statistics
      connection.execute("
        SELECT
          categories.name AS name,
          COUNT(comics_categories.id) AS id_comics,
          COALESCE(SUM(sub_comics.views), 0) AS id_views,
          COALESCE(SUM(sub_comics.likes), 0) AS id_likes,
          COALESCE(CAST(SUM(sub_comics.follows) AS INTEGER), 0) AS id_follows
        FROM categories
        LEFT JOIN comics_categories ON comics_categories.category_id = categories.id
        LEFT JOIN (
          SELECT comics.id AS id, views, likes, COUNT(follows.id) AS follows FROM comics
          LEFT JOIN follows ON follows.comic_id = comics.id
          GROUP BY comics.id
        ) AS sub_comics
        ON sub_comics.id = comics_categories.comic_id
        GROUP BY categories.id
      ")
    end
  end
end
