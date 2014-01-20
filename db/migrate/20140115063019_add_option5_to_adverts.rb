class AddOption5ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :option_5, :string
  end
end
