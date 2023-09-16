# frozen_string_literal: true

class Author < ApplicationRecord
  has_one_attached :image

  has_many :authors_comics, dependent: :destroy
  has_many :comics, through: :authors_comics

  validates :firstname,
            :lastname,
            :birthday,
            :introduction,
            presence: true

  validates :birthday, timeliness: { on_or_before: -> { Time.zone.now }, type: :date }
  validates :birthday, timeliness: { on_or_after: -> { Time.zone.parse('1900-01-01 00:00:00') }, type: :date }

  class << self
    def filter(params)
      authors = all

      if params[:query].present?
        query = params[:query].strip

        authors = authors.where(
          'firstname ILIKE ? OR lastname ILIKE ? OR introduction ILIKE ?',
          "%#{query}%", "%#{query}%", "%#{query}%"
        )
      end

      if params[:sort_by].present?
        sort_by = params[:sort_by].split(',').map { |t| t.split('-') }
        sort_by = sort_by.select { |t| t[0].in?(%w[firstname lastname created_at]) && t[1].in?(%w[asc desc]) }
        sort_by = sort_by.map { |t| "authors.#{t[0]} #{t[1]}" }

        authors = authors.order(sort_by.join(', '))
      end

      authors
    end
  end
end
