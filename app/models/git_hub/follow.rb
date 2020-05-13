module GitHub
  class Follow < GitHub::User
    def self.list_all(gh_token)
      followings = GitHubService.new(gh_token).following

      followings.map do |following_hash|
        GitHub::Follow.new(following_hash)
      end
    end
  end
end
