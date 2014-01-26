class Ressource < ActiveRecord::Base
  
  attr_accessible :community_id, :link, :title, :type, :user_id
  
	belongs_to :owner , :class_name => "User", :foreign_key => "user_id"
  belongs_to :community
  
  has_many :res_upvotes, :class_name => "ResUpvotes"
  has_many :users, :through => :res_upvotes
  
  validates_presence_of :link, :on => :create
  validates_presence_of :title, :on => :create
        
      
  def self.top(community_id)
    select("ressources.*, count(res_upvotes.ressource_id) as votes_count").
    joins(:res_upvotes).
    group('ressources.id').
    where("ressources.community_id = ?", community_id).
    order("votes_count DESC")
    #limit(10) 
  end
  
  def self.else(community_id) 
    if(ResUpvotes.pluck(:ressource_id).uniq.count == 0)
      Ressource.all
    else 
      select("ressources.*").
      where("ressources.id not in (?) AND ressources.community_id = (?)", ResUpvotes.pluck(:ressource_id).uniq, community_id)
    end    
  end
      
  
  def upvotes
    self.users.count
  end
  
end

