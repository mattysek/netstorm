class AddActionToMessage < ActiveRecord::Migration
  def change
	add_column :messages, :action, :string
  end
end
