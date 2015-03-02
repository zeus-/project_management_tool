class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project
  
  def create
    @task = Task.new task_params
    @task.project = @project
    @task.user = current_user
    respond_to do |f|
      if @task.save
        f.html { redirect_to @project, notice: "Made new incomplete task!"}
        f.js { render }
      else
        f.html { flash[:alert] = "Please correct your task form!" 
        redirect_to project_path(@project, task: task_params) }
        f.js { render } 
      end
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id]) 
  end

  def update
    @task = @project.tasks.find(params[:id]) 
    @task.current_user = current_user.first_name
    respond_to do |f| 
      if @task.update(params.require(:task).permit([:done]))
        if @task.done == true && @task.user != current_user
          TasksMailer.delay.notify_task_owner(@task)
        end
        f.js { render }      
      elsif @task.update( params.require(:task).permit([:title, :body, :due_date]))
      f.html { redirect_to @project, notice: "Updated task!" } 
      else        
        f.html {flash[:alert] = "Sorry something went wrong!"
        redirect_to project_task_path(@project, @task, task: task_params) }
        f.js {render js: "alert('500 Internal server error');"}
      end
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id]) 
    respond_to do |f|
      if @task.user == current_user && @task.destroy
        f.js { render }
        f.html { redirect_to @project, notice: "Task deleted" }
      else
        f.js   {render js: "alert('200 You cant delete other ppls tasks');"}
        f.html { flash[:alert] = "You can't delete this task!" 
        redirect_to @project }
      end
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
