require 'rails_helper'

RSpec.describe GitHub::Repo, type: :model do
  it "exists" do
    attributes = {
      name: "bob-repo",
      html_url: "www.github.com/users/bob/bob-repo"
    }

    repo = GitHub::Repo.new(attributes)

    expect(repo).to be_a(GitHub::Repo)
    expect(repo.name).to eq("bob-repo")
    expect(repo.url).to eq("www.github.com/users/bob/bob-repo")
  end
end
