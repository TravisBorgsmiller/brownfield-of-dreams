class GithubService

  def initialize(token)
    @github_token = token
  end

  def retrieve_repos
    response = conn.get('/user/repos?page=1&per_page=5&affiliation=owner')
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com/') do |faraday|
      faraday.headers['Authorization'] = "token #{@github_token}"
      faraday.adapter Faraday.default_adapter
    end
  end

end
