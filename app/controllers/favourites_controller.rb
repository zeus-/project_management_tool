class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    project  = Project.find params[:project_id]
    fav      = project.favourites.new
    fav.user = current_user
    if project.user != current_user && fav.save
      redirect_to project, notice: "I love u too, babeh!"
    else
      redirect_to project, alert: "You cant love yourself that much!"
    end
  end

  def destroy
    project = Project.find params[:project_id]
    fav = project.favourites.find params[:id]
    if fav.user == current_user && fav.destroy
      redirect_to project, notice: "Go faq urself!"
    else
      redirect_to project, alert: "Dont hate the player, hate the game!"
    end
  end

end
