class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if tutorial_params[:playlist_id]
      tutorial = Tutorial.import_from_playlist(tutorial_params[:playlist_id])
      flash[:success] = "Successfully created tutorial. #{view_context.link_to 'View it here', tutorial_path(tutorial)}."
      redirect_to admin_dashboard_path
    end
  end

  def new
    @tutorial = Tutorial.new
    render :new_import if params['import']
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
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :playlist_id)
  end
end
