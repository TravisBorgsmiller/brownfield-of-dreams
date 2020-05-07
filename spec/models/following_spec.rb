require 'rails_helper'

RSpec.describe GitHub::Following, type: :model do
  it "exists" do
    attributes = {
      login: "bob",
      html_url: "www.github.com/users/bob"
    }

    following = GitHub::Following.new(attributes)

    expect(following).to be_a(GitHub::Following)
    expect(following.login).to eq("bob")
    expect(following.url).to eq("www.github.com/users/bob")
  end
end
