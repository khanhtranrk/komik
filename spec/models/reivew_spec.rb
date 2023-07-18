require 'rails_helper'

RSpec.describe :review, type: :model do
  let!(:user) { create(:user) }
  let!(:comic) { create(:comic) }

  it "is valid" do
    expect(build(:review, user_id: user.id, comic_id: comic.id).save).to be true
  end

  it "is invalid without title" do
    expect(build(:review, title: nil, user_id: user.id, comic_id: comic.id).save).to be false
  end

  it "is invalid without content" do
    expect(build(:review, content: nil, user_id: user.id, comic_id: comic.id).save).to be false
  end
end
