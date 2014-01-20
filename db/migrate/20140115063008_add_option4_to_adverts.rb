class AddOption4ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :option_4, :string
  end
end
