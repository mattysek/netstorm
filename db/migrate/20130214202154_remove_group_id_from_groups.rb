class RemoveGroupIdFromGroups < ActiveRecord::Migration
  def up
  	remove_column :groups, :group_id
  end
end
