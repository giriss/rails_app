class RemoveOption3FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :option_3, :string
  end
end
