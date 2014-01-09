class CreateErrorLogs < ActiveRecord::Migration
  def change
    create_table :error_logs do |t|
      t.integer :user_id
      t.string :detail
      t.string :controller_action

      t.timestamps
    end
  end
end
