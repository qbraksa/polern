class UsersController < ApplicationController
  
  before_filter :logged_in, :only => [:show, :index]
  before_filter :admin_only, :only => [:index]
  
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @communities = @user.communities
    @ressources = @user.posted_ressources
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 2)
  end
  
  
  protected    
      def logged_in
        redirect_to sessions_new_path if current_user.nil?
      end
      
      def admin_only
        redirect_to root_path if !current_user.admin
      end
  
end
