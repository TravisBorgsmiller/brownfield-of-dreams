module GitHub
  class Repo
    attr_reader :name, :url

    def initialize(data)
      @name = data[:name]
      @url = data[:html_url]
    end

    def self.list_recent(gh_token)
      all_repos = GitHubService.new(gh_token).repo_info

      all_repos[0..4].map do |repo|
        Repo.new(repo)
      end
    end
  end
end