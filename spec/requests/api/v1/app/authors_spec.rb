require 'rails_helper'

RSpec.describe "Api::V1::App::Authors", type: :request do
  describe "GET #show" do
    let!(:author) { create(:author) }
    before { get api_v1_app_author_path(author.id), headers: @headers }

    it "returns a status code of 200" do
      expect(response).to have_http_status(200)
    end
  end
end
