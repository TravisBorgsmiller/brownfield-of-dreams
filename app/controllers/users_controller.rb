class UsersController < ApplicationController
  def show
    @repos = GitHub::Repo.list_recent(gh_token) if gh_token
    @followers = GitHub::Follower.list_all(gh_token) if gh_token
    @following = GitHub::Following.list_all(gh_token) if gh_token
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
