require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :thumbnail }
  end
  describe "methods" do
    it "does exist" do
      attributes = {
          title: "Shredding gnar",
          description: "Skiing down the slopes on a big pow day",
          thumbnail: "https://pbs.twimg.com/profile_images/669238564543041536/F8oJKPUG_400x400.jpg"
      }

      tutorial = Tutorial.new(attributes)

      expect(tutorial).to be_a Tutorial

      expect(tutorial.title).to eq("Shredding gnar")
      expect(tutorial.description).to eq("Skiing down the slopes on a big pow day")
      expect(tutorial.thumbnail).to eq("https://pbs.twimg.com/profile_images/669238564543041536/F8oJKPUG_400x400.jpg")
    end
  end
end
