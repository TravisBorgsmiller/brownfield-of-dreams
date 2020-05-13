require 'rails_helper'

RSpec.describe GitHub::Follow, type: :model do
  it "self.list_all" do
    VCR.use_cassette('model_following') do
      list_all = GitHub::Follow.list_all(ENV['GITHUB_TOKEN1'])

      expect(list_all).to be_a(Array)
      expect(list_all.first).to be_a(GitHub::Follow)
    end
  end
end
