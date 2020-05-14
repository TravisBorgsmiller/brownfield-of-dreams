class UsersController < ApplicationController
  def show
    @bookmarks = current_user.bookmarks
    return unless gh_token

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
    current_user.update(gh_token: token, gh_uid: uid)
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def token
    request.env['omniauth.auth']['credentials']['token']
  end

  def uid
    request.env['omniauth.auth']['uid']
  end
end
