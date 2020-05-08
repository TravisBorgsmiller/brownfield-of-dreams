require 'rails_helper'

RSpec.describe GitHub::Following, type: :model do
  it "exists" do
    attributes = {
      login: "bob",
      html_url: "www.github.com/users/bob"
    }

    follower = GitHub::Following.new(attributes)

    expect(follower).to be_a(GitHub::Following)
    expect(follower.login).to eq("bob")
    expect(follower.url).to eq("www.github.com/users/bob")
  end
end