require 'rails_helper'

RSpec.describe "Api::V1::App::Comics", type: :request do
  describe "GET #index" do
    let!(:comics) { create_list(:comic, 10) }
    before { get api_v1_app_comics_path, headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    let!(:comic) { create(:comic) }
    before { get api_v1_app_comic_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #favorite" do
    let!(:comic) { create(:comic) }
    before { post favorite_api_v1_app_comic_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #unfavorite" do
    let!(:comic) { create(:comic) }
    before { post favorite_api_v1_app_comic_path(comic.id), headers: @headers }
    before { post unfavorite_api_v1_app_comic_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #follow" do
    let!(:comic) { create(:comic) }
    before { post follow_api_v1_app_comic_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #unfollow" do
    let!(:comic) { create(:comic) }
    before { post follow_api_v1_app_comic_path(comic.id), headers: @headers }
    before { post unfollow_api_v1_app_comic_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #favorited" do
    before { get favorited_api_v1_app_comics_path, headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #followed" do
    before { get followed_api_v1_app_comics_path, headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #up_coming" do
    before { get up_coming_api_v1_app_comics_path, headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #read" do
    before { get read_api_v1_app_comics_path, headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end
end
