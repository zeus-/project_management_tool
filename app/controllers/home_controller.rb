class HomeController < ApplicationController
  
  def index
  end
  
  def about  
  end

  def faves 
    @faves = current_user.favourited_projects
  end

end

