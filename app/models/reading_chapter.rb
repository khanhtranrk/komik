# frozen_string_literal: true

class ReadingChapter < ApplicationRecord
  belongs_to :user
  belongs_to :comic
  belongs_to :chapter
end
