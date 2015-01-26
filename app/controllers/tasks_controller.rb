class TasksController < ApplicationController

  def index
   # @tasks = Task.all
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params) 
    if @task.save
      redirect_to @project, notice: "Made new incomplete task!"
    else
      flash.now[:alert] = "Sorry something went wrong!"
      render "projects/show"
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id]) 
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id]) 
    if @task.update_attributes(task_params) 
      redirect_to @project, notice: "Updated successfully"
    else
      flash.now[:alert] = "Update failed"
      render "/projects/edit"
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id]) 
    if @task.destroy
      redirect_to @project, notice: "Task deleted"
    else
      flash.now[:alert] = "Failed to delete!"
      render "/projects/show"
    end
  end

  private 
    def task_params
      params.require(:task).permit([:title, :body, :done, :due_date])
    end
end
