class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    four_oh_four unless tutorial.classroom == false || current_user
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
