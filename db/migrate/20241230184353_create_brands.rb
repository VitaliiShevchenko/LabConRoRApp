class CreateBrands < ActiveRecord::Migration[7.2]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :desc
      t.string :intended_use
      t.references :creator, null: false, foreign_key: true
      t.float :calculated_cost

      t.timestamps
    end
  end
end
