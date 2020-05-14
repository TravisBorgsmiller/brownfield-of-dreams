class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if params[:commit] == 'Save'
      manual_tutorial
    else
      import_tutorial
    end
  end

  def new
    @tutorial = Tutorial.new
    render :new_import if params[:import] == 'playlist'
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} deleted!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list,
                                     :playlist_id,
                                     :title,
                                     :description,
                                     :thumbnail)
  end

  def manual_tutorial
    @tutorial = Tutorial.new(tutorial_params)
    Video.import_from_yt(params[:video_id], @tutorial) if params[:video_id]
    if @tutorial.save
      flash[:success] = 'Successfully created tutorial.'
      redirect_to tutorial_path(@tutorial)
    else
      flash[:error] = @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def import_tutorial
    tutorial = Tutorial.import_from_playlist(tutorial_params[:playlist_id])
    flash[:success] = "Successfully created tutorial. \
      #{view_context.link_to 'View it here', tutorial_path(tutorial)}."
    redirect_to admin_dashboard_path
  end
end
