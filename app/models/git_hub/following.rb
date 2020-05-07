module GitHub
  class Following
    attr_reader :login, :url

    def initialize(attributes)
      @login = attributes[:login]
      @url = attributes[:html_url]
    end

    def self.list(gh_token)
      followings = GitHubService.new(gh_token).following

      followings.map do |following_hash|
        Following.new(following_hash)
      end
    end
  end
end
