class RemoveWrongOption3FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :wrong_option3, :string
  end
end
