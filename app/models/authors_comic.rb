# frozen_string_literal: true

class AuthorsComic < ApplicationRecord
  belongs_to :comic
  belongs_to :author
end
