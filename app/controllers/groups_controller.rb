class GroupsController < ApplicationController
	def new
		# TODO require login?
		redirect_to :login unless session[:user_id]
	end

  def create
  	#TODO some better validation (at least view or even better client side validation)
  	@group = Group.new(params[:group])

  	if @group.valid?
  		@group.save!
  	else 
  		render :text => "group not valid: " + @group.errors.inspect
  	end

  	@group.update_attribute(:channel, params[:group][:name])
  end

  def find
  end

  def edit
  end
end
