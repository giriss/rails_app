class RemoveWrongOption2FromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :wrong_option2, :string
  end
end
