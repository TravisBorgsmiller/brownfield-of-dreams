class WelcomeController < ApplicationController
  def index
    tutorials = (current_user ? Tutorial.all : Tutorial.where(classroom: false))
    tutorials = tutorials.tagged_with(params[:tag]) if params[:tag]
    @tutorials = tutorials.paginate(page: params[:page], per_page: 5)
  end
end
