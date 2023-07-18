require 'rails_helper'

RSpec.describe Evaluate, type: :model do
  let!(:user) { create(:user) }
  let!(:comic) { create(:comic) }
  let!(:review) { create(:review, user_id: user.id, comic_id: comic.id) }

  it "is valid" do
    expect(build(:evaluate, user_id: user.id, review_id: review.id).save).to be true
  end

  describe "is invalid" do
    before { create(:evaluate, user_id: user.id, review_id: review.id) }

    it "without unique (user, review)" do
      expect(build(:evaluate, user_id: user.id, review_id: review.id).save).to be false
    end
  end
end
