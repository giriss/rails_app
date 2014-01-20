class ChangeDescriptionFormatInAdvertDetails < ActiveRecord::Migration
  def change
  	change_column :advert_details, :description, :string
  end
end
