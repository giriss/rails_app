class RemoveOption4FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :option_4, :string
  end
end
