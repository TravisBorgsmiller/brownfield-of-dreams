class GitHubService
  def initialize(gh_token)
    @gh_token = gh_token
  end

  def repo_info
    params = { sort: 'updated' }

    get_json('/user/repos', params)
  end

  private

  def get_json(url, params)
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
