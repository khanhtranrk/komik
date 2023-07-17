require 'rails_helper'

RSpec.describe "Api::V1::App::Comics", type: :request do
  let!(:comic) { create(:comic) }

  describe "GET #index" do
    let!(:comics) { create_list(:comic, 1) }
    before { get api_v1_app_comics_path, headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before { get api_v1_app_comic_path(comic.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end
end
