class CreateDataFlows < ActiveRecord::Migration[7.2]
  def change
    create_table :data_flows do |t|
      t.float :torque
      t.integer :speed
      t.integer :mold_temp
      t.integer :material_temp
      t.integer :testing_time
      t.integer :voltage
      t.float :current
      t.float :frequency
      t.float :power
      t.float :energy
      t.integer :alarm
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
