require 'rails_helper'

RSpec.describe "Api::V1::App::Categories", type: :request do
  describe "GET #index" do
    let!(:categories) { create_list(:category, 1) }
    before { get api_v1_app_categories_path, headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end
end
