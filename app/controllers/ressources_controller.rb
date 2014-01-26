class RessourcesController < ApplicationController
  
  def create 
    ressource = Ressource.new(params[:ressource])
    #debugger
    if ressource.save 
      redirect_to(request.referer)
    else
      redirect_to(request.referer)
    end
  end
  
  def destroy
    Ressource.destroy(params[:id])
    redirect_to :back
  end
  
  def index
    all = Ressource.top(1) | Ressource.else(1)
    @ressources = all.paginate(:page => params[:page], :per_page => 2)
  end
  
  
  def upvote 
    ressource = Ressource.find(params[:id])
    current_user.upvoted_ressources << ressource
    redirect_to(:back)
  end 
  
  def downvote 
    current_user.upvoted_ressources.destroy(Ressource.find(params[:id]))
    redirect_to(:back)
  end
  
  
end
