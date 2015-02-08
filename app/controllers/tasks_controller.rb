class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project
  
  def create
    @task = Task.new task_params
    @task.project = @project
    @task.user = current_user
    if @task.save
      redirect_to @project, notice: "Made new incomplete task!"
    else
      flash[:alert] = "Please correct your task form!"
      redirect_to project_path(@project, task: task_params)
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id]) 
  end

  def update
    @task = @project.tasks.find(params[:id]) 
    if @task.update(task_params) 
      redirect_to @project, notice: "Updated successfully"
    else
      flash[:alert] = "Sorry something went wrong!"
      redirect_to project_task_path(@project, @task, task: task_params)
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id]) 
    if @task.user == current_user && @task.destroy
      redirect_to @project, notice: "Task deleted"
    else
      flash[:alert] = "Failed to delete!"
      redirect_to @project 
    end
  end

  private 
    def task_params
      params.require(:task).permit([:title, :body, :done, :due_date])
    end
    
    def find_project
      @project = Project.find(params[:project_id])
    end
end
