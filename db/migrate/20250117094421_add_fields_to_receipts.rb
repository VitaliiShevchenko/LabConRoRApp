class AddFieldsToReceipts < ActiveRecord::Migration[7.2]
  def change
    add_column :receipts, :short_name, :string
    add_column :receipts, :sum_S, :float
    add_column :receipts, :volume_cc, :float
    add_column :receipts, :note, :string
  end
end
