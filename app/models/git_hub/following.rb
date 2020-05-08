module GitHub
  class Following < GitHub::User
    def self.list_all(gh_token)
      following = GitHubService.new(gh_token).following

      following.map do |following_hash|
        GitHub::Following.new(following_hash)
      end
    end
  end
end
