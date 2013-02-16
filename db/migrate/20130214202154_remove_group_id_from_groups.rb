class RemoveGroupIdFromGroups < ActiveRecord::Migration
  def up
  	remove_column :groups, :group_id
  	add_column :groups, :supervisor, :integer
  end
end
