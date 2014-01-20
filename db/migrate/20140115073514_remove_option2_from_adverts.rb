class RemoveOption2FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :option_2, :string
  end
end
