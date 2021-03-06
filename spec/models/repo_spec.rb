require 'rails_helper'

RSpec.describe GitHub::Repo, type: :model do
  before(:each) do
  end

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

  it "self.list_recent" do
    VCR.use_cassette('model_repo') do
      list_all = GitHub::Repo.list_recent(ENV['GITHUB_TOKEN1'])

      expect(list_all).to be_a(Array)
      expect(list_all.first).to be_a(GitHub::Repo)
    end
  end
end
