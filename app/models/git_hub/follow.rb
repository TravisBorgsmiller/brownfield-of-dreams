module GitHub
  class Follow < GitHub::User
    def self.list_all(gh_token)
      following = GitHubService.new(gh_token).following

      following.map do |follow_hash|
        GitHub::Follow.new(follow_hash)
      end
    end
  end
end
