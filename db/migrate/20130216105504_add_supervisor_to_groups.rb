class AddSupervisorToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :supervisor, :integer
  end
end
