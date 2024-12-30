class CreateTests < ActiveRecord::Migration[7.2]
  def change
    create_table :tests do |t|
      t.references :brand_receipt, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: true
      t.integer :total_time
      t.float :temperature
      t.float :torque1
      t.integer :time1
      t.float :torque2
      t.integer :time2
      t.float :torque3
      t.integer :time3
      t.float :torque4
      t.integer :time4
      t.integer :melting_time
      t.integer :start_melting
      t.integer :end_melting
      t.float :total_energy
      t.float :te_persec

      t.timestamps
    end
  end
end
