class GithubFascade

  def initialize(current_user)
    @token = current_user.first_name
  end

  def get_repos
    ghservice = GithubService.new(@token)
    response = ghservice.retrieve_repos
    binding.pry
  end

end
