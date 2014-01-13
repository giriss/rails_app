class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.integer :user_id
      t.float :amount
      t.string :type

      t.timestamps
    end
  end
end
