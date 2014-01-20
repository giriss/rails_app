class AddWrongOption3ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :wrong_option3, :string
  end
end
