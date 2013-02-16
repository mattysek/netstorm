class CreateUsersGroupsTable < ActiveRecord::Migration
  def up
  	create_table :users_groups, :id => false do |t|
  		t.references :user
  		t.references :group
  	end
  	add_index :users_groups, [:user_id, :group_id]
  	add_index :users_groups, [:group_id, :user_id]
  end
end
