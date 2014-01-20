class AddOption3ToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :option_3, :string
  end
end
