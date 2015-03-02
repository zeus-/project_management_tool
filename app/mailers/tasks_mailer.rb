class TasksMailer < ApplicationMailer
  default from: "pmstool@example.com"

  def notify_task_owner(task)
    @task = task
    @user = @task.user
    mail to: @user.email, subject: "#{@task.title} has been completed!"
  end

end
