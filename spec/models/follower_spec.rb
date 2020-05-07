require 'rails_helper'

RSpec.describe GitHub::Follower, type: :model do
  it "exists" do
    attributes = {
      login: "bob",
      html_url: "www.github.com/users/bob"
    }

    follower = GitHub::Follower.new(attributes)

    expect(follower).to be_a(GitHub::Follower)
    expect(follower.login).to eq("bob")
    expect(follower.url).to eq("www.github.com/users/bob")
  end

    it "self.list_all" do
      list_all = GitHub::Follower.list_all(ENV['GITHUB_TOKEN1'])

      expect(list_all).to be_a(Array)
      expect(list_all.first).to be_a(GitHub::Follower)
    end
end
