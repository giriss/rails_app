class CreatePreviewAdvertDetails < ActiveRecord::Migration
  def change
    create_table :preview_advert_details do |t|
      t.integer :advert_id
      t.string :ad_title
      t.string :description
      t.string :images
      t.string :video

      t.timestamps
    end
  end
end
