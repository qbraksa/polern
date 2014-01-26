class Community < ActiveRecord::Base
  attr_accessible :category, :name
  has_many :subscriptions
  has_many :ressources
  has_many :users, :through => :subscriptions
  
  validates_presence_of :name, :on => :create
  
  
end
