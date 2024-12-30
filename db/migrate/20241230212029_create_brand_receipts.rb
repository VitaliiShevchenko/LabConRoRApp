class CreateBrandReceipts < ActiveRecord::Migration[7.2]
  def change
    create_table :brand_receipts do |t|
      t.references :brand, null: false, foreign_key: true
      t.integer :hardnessShA
      t.integer :hardnessShD
      t.float :density
      t.integer :receipt_num

      t.timestamps
    end
  end
end
