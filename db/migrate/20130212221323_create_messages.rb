class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :author
      t.text :content
      t.string :channel

      t.timestamps
    end
  end
end
