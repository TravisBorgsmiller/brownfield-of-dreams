module GitHub
  class Follower
    attr_reader :login, :url

    def initialize(follower)
      @login = follower[:login]
      @url = follower[:html_url]
    end

    def self.list(gh_token)
      followers = GitHubService.new(gh_token).followers

      followers.map do |follower|
        Follower.new(follower)
      end
    end
  end
end
