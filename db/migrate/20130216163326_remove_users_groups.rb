class RemoveUsersGroups < ActiveRecord::Migration
  def up
  	drop_table :users_groups
  end
end
