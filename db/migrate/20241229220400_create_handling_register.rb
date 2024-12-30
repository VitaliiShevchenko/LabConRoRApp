class CreateHandlingRegister < ActiveRecord::Migration[7.2]
  def change
    create_table :handling_registers do |t|
      t.string :name
      t.integer :address
      t.string :description
      t.integer :value

      t.timestamps
    end
  end
end
