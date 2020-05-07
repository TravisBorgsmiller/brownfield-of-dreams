module GitHub
  class Repo
    attr_reader :name, :url

    def initialize(attributes)
      @name = attributes[:name]
      @url = attributes[:html_url]
    end

    def self.list_recent(gh_token)
      repos = GitHubService.new(gh_token).repos

      repos[0..4].map do |repo_hash|
        Repo.new(repo_hash)
      end
    end
  end
end
