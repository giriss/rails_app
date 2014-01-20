class AddRightOptionToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :right_option, :string
  end
end
