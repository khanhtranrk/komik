require 'rails_helper'

RSpec.describe "Api::V1::App::Reviews", type: :request do
  describe "GET #index" do
    let!(:comic) { create(:comic) }
    before { get api_v1_app_comic_reviews_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    let!(:comic) { create(:comic) }
    before {
      post api_v1_app_comic_reviews_path(comic.id),
           params: {
             review: {
               title: "title",
               content: "content"
             }
           },
           headers: @headers
    }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #user_review" do
    let!(:comic) { create(:comic) }
    before { post api_v1_app_comic_reviews_path(comic.id), headers: @headers }
    before { get user_review_api_v1_app_comic_reviews_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end
end
