class CreateSkipAdDetails < ActiveRecord::Migration
  def change
    create_table :skip_ad_details do |t|
      t.string :token
      t.string :ad_key
      t.datetime :start_time
      t.datetime :end_time
      t.integer :attempt

      t.timestamps
    end
  end
end
