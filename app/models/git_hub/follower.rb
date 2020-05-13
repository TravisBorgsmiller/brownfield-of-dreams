module GitHub
  class Follower < GitHub::User
    def self.list_all(gh_token)
      followers = GitHubService.new(gh_token).followers

      followers.map do |follower_hash|
        GitHub::Follower.new(follower_hash)
      end
    end
  end
end
