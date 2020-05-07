module GitHub
  class Following
    attr_reader :login, :url

    def initialize(following)
      @login = following[:login]
      @url = following[:html_url]
    end

    def self.list(gh_token)
      followings = GitHubService.new(gh_token).following

      followings.map do |following|
        Following.new(following)
      end
    end
  end
end
