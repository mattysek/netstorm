class Group < ActiveRecord::Base
  attr_accessible :name, :topic
  has_many :users
  validates :name,  :presence => true, :uniqueness => true
end
