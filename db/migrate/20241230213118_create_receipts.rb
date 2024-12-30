class CreateReceipts < ActiveRecord::Migration[7.2]
  def change
    create_table :receipts do |t|
      t.references :brand_receipt, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
