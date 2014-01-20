class RemoveOption1FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :option_1, :string
  end
end
