class GitHubService
  def initialize(gh_token)
    @gh_token = gh_token
  end

  def repos
    params = { sort: 'updated' }

    get_json('/user/repos', params)
  end

  def followers
    get_json('/user/followers')
  end

  def following
    get_json('/user/following')
  end

  private

  def get_json(url, params = nil)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.authorization :Bearer, @gh_token
    end
  end
end
