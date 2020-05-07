module GitHub
  class Repo
    attr_reader :name, :url

    def initialize(repo_info)
      @name = repo_info[:name]
      @url = repo_info[:html_url]
    end

    def self.list_recent(gh_token)
      all_repo_info = GitHubService.new(gh_token).repo_info

      all_repo_info[0..4].map do |repo_info|
        Repo.new(repo_info)
      end
    end
  end
end
