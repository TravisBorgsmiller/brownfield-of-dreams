module GitHub
  class Repo
    attr_reader :name, :url

    def initialize(repo)
      @name = repo[:name]
      @url = repo[:html_url]
    end

    def self.list_recent(gh_token)
      repos = GitHubService.new(gh_token).repos

      repos[0..4].map do |repo|
        Repo.new(repo)
      end
    end
  end
end
