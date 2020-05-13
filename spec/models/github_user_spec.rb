require 'rails_helper'

RSpec.describe GitHub::User, type: :model do
  it "exists" do
    attributes = {
      login: "bob",
      html_url: "www.github.com/users/bob"
    }

    user = GitHub::User.new(attributes)

    expect(user).to be_a(GitHub::User)
    expect(user.login).to eq("bob")
    expect(user.url).to eq("www.github.com/users/bob")
  end
end