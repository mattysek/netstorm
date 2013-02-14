class AddChannelToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :channel, :string
  end
end
