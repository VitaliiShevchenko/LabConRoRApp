class RenameAmountToAmountG < ActiveRecord::Migration[7.2]
  def change
    rename_column :receipts, :amount, :amount_g
  end
end
