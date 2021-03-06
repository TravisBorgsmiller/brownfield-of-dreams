require 'rails_helper'

RSpec.describe GitHub::Follower, type: :model do
    it "self.list_all" do
      VCR.use_cassette('model_follower') do

        list_all = GitHub::Follower.list_all(ENV['GITHUB_TOKEN1'])

        expect(list_all).to be_a(Array)
        expect(list_all.first).to be_a(GitHub::Follower)
      end
    end
end
