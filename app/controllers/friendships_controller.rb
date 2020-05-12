class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(gh_uid: params[:gh_uid])
    friendship = Friendship.new(user: current_user, friend: friend)
    if friendship.save
      flash[:success] = "Successfully added friend"
    else
      flash[:error] = "Unable to find registered user with that GitHub UID"
    end
    redirect_to dashboard_path
  end
end
