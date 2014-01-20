class CreatePreviewImages < ActiveRecord::Migration
  def change
    create_table :preview_images do |t|
      t.integer :user_id
      t.string :extension

      t.timestamps
    end
  end
end
