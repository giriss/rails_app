class AddWebsiteToPreviewAdvertDetails < ActiveRecord::Migration
  def change
    add_column :preview_advert_details, :website, :string
  end
end
