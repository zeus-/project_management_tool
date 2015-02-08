class DiscussionsController < ApplicationController
  before_action :find_project
  before_action :authenticate_user!

  def create
    @discussion = Discussion.new discussion_params 
    @discussion.project = @project
    @discussion.user = current_user
    if @discussion.save
      redirect_to @project, notice: "Made new discussion!"
    else
      flash[:alert] = "Please correct your disccussion params!"
      redirect_to project_path(@project, discussion: discussion_params)
    end
  end

  #def show
   # @discussion = @project.discussions.find(params[:id]) 
   # @comment = Comment.new
  #end
 
  def edit
    @discussion = @project.discussions.find(params[:id]) 
  end

  def update
    @discussion = @project.discussions.find(params[:id]) 
    if @discussion.update(discussion_params) 
      redirect_to project_path(@project), notice: "Updated successfully"
    else
      flash.now[:alert] = "Update failed"
      render "/discussions/edit"
    end
  end

  def destroy
    @discussion = @project.discussions.find(params[:id]) 
    if @discussion.destroy && @discussion.user == current_user
      redirect_to @project, notice: "Discussion deleted"
    else
      flash.now[:alert] = "Failed to delete discussion!"
      render "/projects/show"
    end
  end

  private 
    def discussion_params
      params.require(:discussion).permit([:title, :body])
    end
    def find_project 
      @project = Project.find(params[:project_id])
    end
end
