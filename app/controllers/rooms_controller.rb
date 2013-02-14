class RoomsController < ApplicationController
  def index
  	@chat_messages = Message.where('channel = ? AND action = \'chat\'', params[:channel_name])
	@drawImage_messages = Message.where('channel = ? AND action = \'drawIdea\'', params[:channel_name])
  end

  def create_message
    @message = Message.new(params[:message])
    @message.update_attribute(:channel, params[:channel_name])
    @message.save!
    PrivatePub.publish_to("/channels/" + params[:channel_name], @message.as_json)
  end
end