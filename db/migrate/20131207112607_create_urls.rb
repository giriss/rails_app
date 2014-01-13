class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.integer :user_id
      t.string :key
      t.string :target
      t.integer :views
      t.integer :unique_views

      t.timestamps
    end
  end
end
