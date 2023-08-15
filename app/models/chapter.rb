# frozen_string_literal: true

class Chapter < ApplicationRecord
  default_scope { order(id: :asc) }

  has_many_attached :images

  belongs_to :comic

  validates :name, presence: true

  has_many :readings, dependent: :destroy

  def self.filter(params)
    chapters = all

    if params[:query].present?
      query = params[:query].strip

      chapters = chapters.where('name ILIKE ?', "%#{query}%")
    end

    chapters
  end
end
