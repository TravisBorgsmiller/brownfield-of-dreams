module GitHub
  class Follower
    attr_reader :login, :url

    def initialize(follower_info)
      @login = follower_info[:login]
      @url = follower_info[:html_url]
    end

    def self.list(gh_token)
      all_follower_info = GitHubService.new(gh_token).follower_info

      all_follower_info.map do |follower_info|
        Follower.new(follower_info)
      end
    end
  end
end
