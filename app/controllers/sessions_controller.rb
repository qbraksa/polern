class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to communities_index_path
    else
      flash.now.alert = "Email et/ou mot de passe invalide."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
