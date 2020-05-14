class EmailActivationsController < ApplicationController
  def show
    user = User.find_by(email_token: params[:id])
    if user
      user.activate_email
      flash[:success] = "Your email has been confirmed. \
        Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = 'Sorry this user does not exist'
      redirect_to root_path
    end
  end
end
