class Api::V1::App::SearchingsController < ApplicationController
  def suggest_keywords
    keywords = Comic.select("name as keyword, 'Keyword' as type").where('name ILIKE ?', "%#{params[:query]}%").limit(20);

    expose keywords: keywords
  end
end
