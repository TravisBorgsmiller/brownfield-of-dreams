class GithubSessionsController < ApplicationController
  def create
    current_user.update!(gh_token: token)
    redirect_to '/dashboard'
  end

  private

  def token
    request.env['omniauth.auth']['credentials']['token']
  end
end
