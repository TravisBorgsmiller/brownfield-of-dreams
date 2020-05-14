class UsersController < ApplicationController
  def show
    @bookmarks = current_user.bookmarks
    gh_token = current_user.gh_token
    return if gh_token.nil?

    @repos = GitHub::Repo.list_recent(gh_token)
    @followers = GitHub::Follower.list_all(gh_token)
    @following = GitHub::Follow.list_all(gh_token)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.first_name}"
      RegistrationMailer.activate(@user).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    current_user.update(gh_token: retrieve_token, gh_uid: retrieve_uid)
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def retrieve_token
    request.env['omniauth.auth']['credentials']['token']
  end

  def retrieve_uid
    request.env['omniauth.auth']['uid']
  end
end
