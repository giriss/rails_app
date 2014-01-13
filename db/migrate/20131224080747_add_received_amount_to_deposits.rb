class AddReceivedAmountToDeposits < ActiveRecord::Migration
  def change
    add_column :deposits, :received_amount, :float
  end
end
