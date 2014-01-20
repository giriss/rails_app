class AddCorrectOptionToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :correct_option, :string
  end
end
