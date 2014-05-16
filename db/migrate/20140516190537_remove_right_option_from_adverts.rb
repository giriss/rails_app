class RemoveRightOptionFromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :right_option, :string
  end
end
