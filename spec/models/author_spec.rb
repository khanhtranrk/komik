require 'rails_helper'

RSpec.describe Author, type: :model do
  it "is valid" do
    expect(build(:author).save).to be true
  end

  it "is invalid without firstname" do
    expect(build(:author, firstname: nil).save).to be false
  end

  it "is invalid without lastname" do
    expect(build(:author, lastname: nil).save).to be false
  end

  it "is invalid without birthday" do
    expect(build(:author, birthday: nil).save).to be false
  end

  it "is invalid without an introduction" do
    expect(build(:author, introduction: nil).save).to be false
  end
end
