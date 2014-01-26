class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  
  validates_presence_of :password, :on => :create
  validates_presence_of :name, :on => :create
  validates_presence_of :email, :on => :create
  
  has_many :subscriptions  
  has_many :communities, :through => :subscriptions #a user can subscribe to communities through subscriptions
  has_many :posted_ressources, :class_name => "Ressource"
  
  has_many :res_upvotes, :class_name => "ResUpvotes"
  has_many :upvoted_ressources, :through => :res_upvotes, 
                                :class_name => "Ressource", 
                                :foreign_key => 'ressource_id',
                                :source => :ressource
  
  def follow(community)
      !self.communities.where("community_id = ?",community.id).empty?
  end
  
  def upvoted?(ressource_id)
      !self.upvoted_ressources.where("ressource_id = ?", ressource_id).empty?      
  end
  
  def own(ressource)
    ressource.owner.id == self.id
  end
  
end
