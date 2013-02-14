class Message < ActiveRecord::Base
  attr_accessible :author, :channel, :content, :action
end
