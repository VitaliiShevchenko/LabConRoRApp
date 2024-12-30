class CreateSuppliers < ActiveRecord::Migration[7.2]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.string :website
      t.string :contact_person
      t.string :note
      t.string :product_list

      t.timestamps
    end
  end
end
