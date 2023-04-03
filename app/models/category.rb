# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :comics_categories, dependent: :delete_all
  has_many :comics, through: :comics_categories

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
  end
end
