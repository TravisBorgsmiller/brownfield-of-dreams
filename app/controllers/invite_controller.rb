class InviteController < ApplicationController
  def new
  end

  def create
    friend = GitHubService.new(current_user.gh_token).get_user(params[:github_handle])
    if friend[:message] == "Not Found"
      flash[:error] = "There is no Github user with that handle."
      render :new
    elsif friend[:email] == nil
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      render :new
    else
      InviteMailer.invite_friend(friend[:email], friend[:name], current_user.first_name).deliver_now
      flash[:success] = "Successfully sent invite!"
      redirect_to dashboard_path
    end
  end
end
