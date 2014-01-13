class AddTokenToDeposits < ActiveRecord::Migration
  def change
    add_column :deposits, :token, :string
  end
end
