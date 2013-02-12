class Group < ActiveRecord::Base
  attr_accessible :group_id, :name
  has_many :users
  validates :name, :group_id, :presence => true 
end
