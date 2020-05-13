class WelcomeController < ApplicationController
  # def index
  #   if params[:tag]
  #     tutorials = Tutorial.tagged_with(params[:tag])
  #     @tutorials = tutorials.paginate(page: params[:page], per_page: 5)
  #   else
  #     @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
  #   end
  # end

  def index
    tutorials = (current_user ? Tutorial.all : Tutorial.where(classroom: false))
    tutorials = tutorials.tagged_with(params[:tag]) if params[:tag]
    @tutorials = tutorials.paginate(page: params[:page], per_page: 5)
  end
end
