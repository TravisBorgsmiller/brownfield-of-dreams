class InvitationsController < ApplicationController
  def new; end

  def create
    friend = GitHubService.new(current_user.gh_token).get_user(params[:handle])
    if friend[:message] == 'Not Found'
      flash[:error] = 'Could not locate GitHub user with that handle.'
      render :new
    elsif friend[:email].nil?
      no_public_email
    else
      invite(friend)
    end
  end

  private

  def invite(friend)
    InvitationMailer.invite_friend(current_user, friend).deliver_now
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end

  def no_public_email
    flash[:error] = "The Github user you selected doesn't have an email \
      address associated with their account."
    render :new
  end
end
