class GroupsController < ApplicationController

	before_filter :authenticate

	def new
		@group = Group.new
	end

  def create
  	@group = Group.new(params[:group])

  	# @group.password = "anypass"
  	# @group.password_salt = "anypasssalt"
  	# render :text => @group.password
  	# @group.set_attribute(:password_salt, BCrypt::Engine.generate_salt)
  	# @group.password_salt = BCrypt::Engine.generate_salt
   #  @group.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    

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

  def join
  	@group = Group.find_by_id(params[:group_id])

  	if request.get?
  		render 'groups/join_form'
  	else
  		if Group.authenticate(@group.name, params[:group][:password])
  			render :text => "OK"
  		else
  			render :text => "wrong password" 
  		end
  	end
  end

  # def find
  # end

  # def edit
  # end

  private

  def authenticate
    redirect_to :login unless current_user
  end
end
