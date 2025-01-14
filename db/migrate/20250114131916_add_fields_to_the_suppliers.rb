class AddFieldsToTheSuppliers < ActiveRecord::Migration[7.2]
  def change
    add_column :suppliers, :active, :boolean
    add_column :suppliers, :address, :string
    add_column :suppliers, :phone, :string
    add_column :suppliers, :product_ids, :string
    add_column :suppliers, :creator_id, :bigint
    add_column :suppliers, :reliability, :decimal
    add_column :suppliers, :country, :string
    add_column :suppliers, :producer, :boolean
    add_column :suppliers, :image, :string
  end
end
