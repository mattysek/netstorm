class CreateTableGroupsUsers < ActiveRecord::Migration
  def up
  	create_table :groups_users, :id => false do |t|
  		t.references :user
  		t.references :group
  	end
  	
  	add_index :groups_users, [:group_id, :user_id]
  	add_index :groups_users, [:user_id, :group_id]
  end
end
