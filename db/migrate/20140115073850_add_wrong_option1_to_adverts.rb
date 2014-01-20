class AddWrongOption1ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :wrong_option1, :string
  end
end
