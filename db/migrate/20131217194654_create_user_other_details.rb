class CreateUserOtherDetails < ActiveRecord::Migration
  def change
    create_table :user_other_details do |t|
      t.integer :user_id
      t.string :tracker_code

      t.timestamps
    end
  end
end
