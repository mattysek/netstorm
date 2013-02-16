class RoomsController < ApplicationController

  before_filter :authenticate
  
  def index
  	@chat_messages = Message.where('channel = ? AND action = \'chat\'', params[:channel_name])
	@save_message = Message.where('channel = ? AND action = \'save\'', params[:channel_name]).order("created_at").last
	if not @save_message
		@drawImage_messages = Message.where('channel = ? AND action = \'drawIdea\'', params[:channel_name])
	end
	@group = Group.where('name = ?', params[:channel_name]).first
  end

  def create_message
    @message = Message.new(params[:message])
    @message.update_attribute(:channel, params[:channel_name])
    @message.save!
    PrivatePub.publish_to("/channels/" + params[:channel_name], @message.as_json)
  end
  
  def authenticate
    redirect_to :login unless current_user && current_user.groups.where('name = ?', params[:channel_name]).first
  end
  
end