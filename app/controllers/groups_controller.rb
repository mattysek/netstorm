class GroupsController < ApplicationController

	before_filter :authenticate

	def new
		@group = Group.new
	end

  def create
  	@group = Group.new(params[:group])

  	@group.supervisor = current_user.id
  	@group.users << current_user

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
  			@group.users << current_user
  			render :text => "OK"
  		else
  			render :text => "wrong password" 
  		end
  	end
  end

  def browse
  	if params[:search]
			@groups = Group.where('name LIKE ? OR topic LIKE ?',
			 "%#{params[:search]}%",
			 "%#{params[:search]}%")
  	else
	  	@groups = Group.all
	  end
  end

  def show_my_groups
  	# @groups = GroupsUsers.joins('JOIN groups_users ON groups_users.group_id = groups.id').where(:user_id => current_user.id)
  	all_groups = Group.all
  	@groups = []

  	all_groups.each do |group|
  		if group.users.include? current_user
  			@groups << group
  		end
  	end
  end

  private

  def authenticate
    redirect_to :login unless current_user
  end
end
