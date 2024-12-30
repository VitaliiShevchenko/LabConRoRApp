class CreateMaterials < ActiveRecord::Migration[7.2]
  def change
    create_table :materials do |t|
      t.datetime :date
      t.string :name
      t.string :desc
      t.references :supplier, null: false, foreign_key: true
      t.float :price
      t.string :note
      t.boolean :available

      t.timestamps
    end
  end
end
