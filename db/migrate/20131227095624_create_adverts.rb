class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.string :name
      t.integer :type
      t.string :url

      t.timestamps
    end
  end
end
