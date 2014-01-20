class RemoveOption5FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :option_5, :string
  end
end
