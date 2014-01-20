class AddOption1ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :option_1, :string
  end
end
