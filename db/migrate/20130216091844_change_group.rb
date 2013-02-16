class ChangeGroup < ActiveRecord::Migration
  def up
  	remove_column :groups, :channel
  end
end
