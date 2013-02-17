class GroupsController < ApplicationController

	before_filter :authenticate

	def new
		@group = Group.new

		render :layout => 'group'
	end

  def create
  	@group = Group.new(params[:group])

  	@group.supervisor = current_user.id
  	@group.users << current_user

  	if @group.save
  		redirect_to(@group, :notice => 'Group was successfully created.') 
  	else
  		render :action => 'new', :target => @group, :layout => 'group'
  	end
  end

  def show 
  	@group = Group.where('id = ?', params[:id])[0]

  	@supervisor = User.where('id = ?', @group.supervisor)[0]

  	render :layout => 'group'
  end

  def join
  	@group = Group.find_by_name(params[:group_name])

  	if request.get?
  		render 'groups/join_form', :layout => 'group'
  	else
  		if Group.authenticate(@group.name, params[:group][:password])
  			@group.users << current_user
  			redirect_to '/chatrooms/' + @group.name.html_safe
  		else
  			flash[:alert] = "You have entered wrong password, try again"
  			render 'groups/join_form', :layout => 'group'
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

	  render :layout => 'group'
  end

  def show_my_groups
  	all_groups = Group.all
  	@groups = []

  	all_groups.each do |group|
  		if group.users.include? current_user
  			@groups << group
  		end
  	end

  	render :layout => 'group'
  end

  private

  def authenticate
    redirect_to :login unless current_user
  end
end
