class AddColumnCalculatedCostToBrandReceipts < ActiveRecord::Migration[7.2]
  def change
    add_column :brand_receipts, :calculated_cost, :float
  end
end
