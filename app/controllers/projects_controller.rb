class ProjectsController < ApplicationController
  
  before_action :find_project, except: [:index, :new, :create, :show]
  
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params) 
    if @project.save
      redirect_to projects_path, notice: "Congrats, you have initialized a project!"
    else
      flash.now[:alert] = "Sorry something went wrong!"
      render :new  
    end
  end

  def show
    @project = Project.find(params[:id] || params[:project_id])
    @task = Task.new
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params) 
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
      params.require(:project).permit([:title, :description, :due_date])
    end

end
