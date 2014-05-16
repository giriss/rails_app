class RemoveWrongOption1FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :wrong_option1, :string
  end
end
