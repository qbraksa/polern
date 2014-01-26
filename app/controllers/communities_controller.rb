class CommunitiesController < ApplicationController
  
  
  
  before_filter :logged_in, :except => ["index"]
  
  def show
    @community = Community.find(params[:id])
    @users = @community.users
    @ressource = Ressource.new    
    all = Ressource.top(params[:id]) | Ressource.else(params[:id])
    @ressources = all.paginate(:page => params[:page], :per_page => 2)
    #@title = Mechanize.new.get('http://nje7t.com').title
  end
  
  def create
    community = Community.new(params[:community])
    if community.save 
      redirect_to communities_index_path
    else 
      render 'new'
    end
  end

  def index
    @communities = Community.all
    @community = Community.new
  end
  
  def subscribe
    @community = Community.find(params[:id])
    current_user.communities << @community
    redirect_to @community
  end

  def unsubscribe
    @community = Community.find(params[:id])
    subscription = current_user.subscriptions.where("community_id = ? AND user_id = ? ", params[:id], current_user.id).first
    Subscription.destroy(subscription.id)
    redirect_to @community
  end
  
  protected    
      def logged_in
        redirect_to sessions_new_path if current_user.nil?
      end
  
end
