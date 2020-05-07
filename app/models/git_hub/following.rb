module GitHub
  # User class to combine follwoer/following
  # or GH user superclass
  class Following < GitHub::User
    def self.list_all(gh_token)
      followings = GitHubService.new(gh_token).following

      followings.map do |following_hash|
        GitHub::User.new(following_hash)
      end
    end
  end
end
