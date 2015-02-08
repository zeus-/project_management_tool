class ProjectsController < ApplicationController
  
  before_action :find_project, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show] 
  
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params) 
    @project.user = current_user
    if @project.save
      redirect_to projects_path, notice: "Congrats, you have initialized a project!"
    else
      flash.now[:alert] = "Sorry something went wrong!"
      render :new  
    end
  end

  def show
    if params[:task]
      @task = Task.new(params.require(:task).permit([:title, :body, :done, :due_date]))
    else
      @task = Task.new
    end
    if params[:discussion]
      @discussion = Discussion.new(params.require(:discussion).permit([
                                                    :title, :body]))
    else 
      @discussion = Discussion.new
    end
    if params[:comment]
      @comment = Comment.new(params.require(:comment).permit([:body]))
    else
      @comment = Comment.new
    end
  end

  def edit
  end

  def update
    if @project.update project_params 
      redirect_to @project, notice: "Updated successfully"
    else
      flash.now[:alert] = "Update failed"
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: "Project deleted"
    else
      flash.now[:alert] = "Failed to delete!"
      render :show
    end
  end

  private 
    def find_project
      @project = Project.find(params[:id])
    end
    def project_params
      params.require(:project).permit(:title, :description,
                                      :due_date, { joined_user_ids: []},
                                      {tag_ids: []})
    end

end
