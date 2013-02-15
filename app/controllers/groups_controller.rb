class GroupsController < ApplicationController

	before_filter :authenticate

	def new
		@group = Group.new
	end

  def create
  	@group = Group.new(params[:group])
  	@group.channel = @group.name

  	if @group.save
  		redirect_to(@group, :notice => 'Group was successfully created.') 
  	else
  		render :action => 'new', :target => @group
  	end
  end

  def show 
  	@group = Group.where('id = ?', params[:id])[0]

  	render @group
  end

  # def find
  # end

  # def edit
  # end

  private

  def authenticate
    redirect_to :login unless session[:user_id]
  end
end
