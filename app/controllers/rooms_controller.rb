class RoomsController < ApplicationController
  def index
  	@messages = Message.where('channel = ?', params[:channel_name])
  end

  def create_message
    @message = Message.new(params[:message])
    @message.update_attribute(:channel, params[:channel_name])
    @message.save!

    # PrivatePub.publish_to("/messages/new", message: @message)
  end
end