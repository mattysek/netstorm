class AddTopicToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :topic, :text
  end
end
