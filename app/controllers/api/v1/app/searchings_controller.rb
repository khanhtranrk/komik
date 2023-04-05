# frozen_string_literal: true

class Api::V1::App::SearchingsController < ApplicationController
  def suggest_keywords
    keywords = Comic.select("name as keyword, 'Keyword' as type")
                    .where('name ILIKE ?', "%#{params[:query]}%")
                    .limit(20)

    expose keywords:
  end
end
