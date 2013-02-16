class AddPasswordToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :password_hash, :string
  	add_column :groups, :password_salt, :string
  end
end
