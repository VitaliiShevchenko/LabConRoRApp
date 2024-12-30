class CreateCoilRegister < ActiveRecord::Migration[7.2]
  def change
    create_table :coil_registers do |t|
      t.string :name
      t.integer :address
      t.string :description
      t.boolean :value

      t.timestamps
    end
  end
end
