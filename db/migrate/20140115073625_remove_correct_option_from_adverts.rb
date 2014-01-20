class RemoveCorrectOptionFromAdverts < ActiveRecord::Migration
  def change
    remove_column :adverts, :correct_option, :string
  end
end
