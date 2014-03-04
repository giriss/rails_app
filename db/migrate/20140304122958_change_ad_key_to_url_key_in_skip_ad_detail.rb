class ChangeAdKeyToUrlKeyInSkipAdDetail < ActiveRecord::Migration
  def change
	  rename_column :skip_ad_details, :ad_key, :url_key
	  add_column :skip_ad_details, :campaign_id, :integer
  end
end
