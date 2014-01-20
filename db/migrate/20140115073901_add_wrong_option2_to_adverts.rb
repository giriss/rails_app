class AddWrongOption2ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :wrong_option2, :string
  end
end
