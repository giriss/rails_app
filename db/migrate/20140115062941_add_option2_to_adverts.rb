class AddOption2ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :option_2, :string
  end
end
