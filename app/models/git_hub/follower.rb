module GitHub
  class Follower
    attr_reader :login, :url

    def initialize(attributes)
      @login = attributes[:login]
      @url = attributes[:html_url]
    end

    def self.list_all(gh_token)
      followers = GitHubService.new(gh_token).followers

      followers.map do |follower_hash|
        Follower.new(follower_hash)
      end
    end
  end
end
