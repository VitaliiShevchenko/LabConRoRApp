class RenameAmountToAmountKg < ActiveRecord::Migration[7.2]
  def change
    rename_column :receipts, :amount, :amount_kg
  end
end
