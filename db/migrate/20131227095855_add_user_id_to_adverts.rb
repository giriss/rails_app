class AddUserIdToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :user_id, :integer
  end
end
