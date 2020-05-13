class UsersController < ApplicationController
  def show
    return unless gh_token

    @repos = GitHub::Repo.list_recent(gh_token)
    @followers = GitHub::Follower.list_all(gh_token)
    @following = GitHub::Following.list_all(gh_token)
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

  def confirm_email
    user = User.find_by(email_token: params[:id])
    if user
      user.email_activate
      flash[:success] = "Your email has been confirmed. Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = "Sorry this user does not exist"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
