class AddWebsiteToAdvertDetails < ActiveRecord::Migration
  def change
    add_column :advert_details, :website, :string
  end
end
