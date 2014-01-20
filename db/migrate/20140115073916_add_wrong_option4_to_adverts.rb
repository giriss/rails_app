class AddWrongOption4ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :wrong_option4, :string
  end
end
