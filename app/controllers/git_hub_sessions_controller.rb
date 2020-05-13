class GitHubSessionsController < ApplicationController
  def create
    current_user.update(gh_token: token, gh_uid: uid)
    redirect_to '/dashboard'
  end

  private

  def token
    request.env['omniauth.auth']['credentials']['token']
  end

  def uid
    request.env['omniauth.auth']['uid']
  end
end
