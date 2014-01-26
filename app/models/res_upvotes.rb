class ResUpvotes < ActiveRecord::Base
  attr_accessible :ressource_id, :user_id
  belongs_to :user
  belongs_to :ressource 
end
