class ProjectsMailer < ApplicationMailer

  def notify_project_owner(user)
    @projects = user.projects.all
    @user = user
    mail to: user.email, subject:"Project report summary"
  end

end
