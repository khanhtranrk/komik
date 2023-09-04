# frozen_string_literal: true

class Comic < ApplicationRecord
  scope :reading_by, lambda { |user_id|
    last_read_case = Arel.sql(<<~SQL)
      CASE
        WHEN A.last_read_at > comics.last_updated_chapter_at THEN A.last_read_at
        ELSE comics.last_updated_chapter_at
      END
    SQL

    select('comics.*, A.last_read_at AS last_read_at, COUNT(new_chapters.id) AS new_chapters')
      .joins(
        <<-SQL
          INNER JOIN (
            SELECT chapters.comic_id AS comic_id, MAX(readings.updated_at) AS last_read_at
            FROM chapters
            INNER JOIN readings ON readings.chapter_id = chapters.id AND user_id = #{user_id}
            GROUP BY chapters.comic_id
          ) AS A ON A.comic_id = comics.id
        SQL
      )
      .joins(
        <<-SQL
          LEFT JOIN chapters AS new_chapters ON new_chapters.comic_id = comics.id AND new_chapters.created_at > A.last_read_at
        SQL
      )
      .where(
        <<-SQL
          NOT EXISTS (
            SELECT 1
            FROM readings
            WHERE readings.chapter_id = new_chapters.id AND readings.user_id = #{user_id}
          )
        SQL
      )
      .group('comics.id, A.last_read_at, comics.last_updated_chapter_at')
      .order(last_read_case.desc)
  }

  has_one_attached :image

  has_many :comics_categories, dependent: :destroy
  has_many :categories, through: :comics_categories
  has_many :chapters, dependent: :destroy
  has_many :favoritez, class_name: 'Favorite', inverse_of: :comic, dependent: :destroy
  has_many :followz, class_name: 'Follow', inverse_of: :comic, dependent: :destroy
  has_many :users_favorited, through: :favoritez, source: :user
  has_many :users_followed, through: :followz, source: :user
  has_many :reviews, dependent: :destroy
  has_many :authors_comics, dependent: :destroy
  has_many :authors, through: :authors_comics

  validates :name, presence: true

  def author_names
    authors.pluck(:firstname).join(', ')
  end

  def favorited_by?(user)
    Favorite.exists?(user:, comic_id: id)
  end

  def followed_by?(user)
    Follow.exists?(user:, comic_id: id)
  end

  def reading_chapter_by(user)
    readings = Reading.where(user:, chapter: chapters)
                      .order(updated_at: :desc)

    readings.first
  end

  class << self
    def filter(params)
      comics = all

      if params[:release_dates].present?
        release_years = params[:release_dates].split(',').map { |date| DateTime.parse(date).year }
        comics = comics.where('EXTRACT(YEAR FROM release_date) IN (?)', release_years)
      end

      if params[:category_ids].present?
        category_ids = params[:category_ids].split(',').map(&:to_i)
        comic_ids = ComicsCategory.where(category_id: category_ids).pluck(:comic_id)
        comics = comics.where(id: comic_ids)
      end

      if params[:query].present?
        query = params[:query].strip

        comics = comics.where(
          'name ILIKE ? OR other_names ILIKE ? OR description ILIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%"
        )
      end

      if params[:sort_by].present?
        sort_by = params[:sort_by].split(',').map { |t| t.split('-') }
        sort_by = sort_by.select { |t| t[0].in?(%w[views favorites follows updated_at last_updated_chapter_at created_at]) && t[1].in?(%w[asc desc]) }
        sort_by = sort_by.map { |t| "comics.#{t[0]} #{t[1]}" }

        comics = comics.order(sort_by.join(', '))
      end

      comics
    end
  end
end
