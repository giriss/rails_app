class RemoveWrongOption4FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :wrong_option4, :string
  end
end
