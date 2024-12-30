class CreateCreators < ActiveRecord::Migration[7.2]
  def change
    create_table :creators do |t|
      t.references :user, null: false, foreign_key: true
      t.string :position
      t.string :order_description

      t.timestamps
    end
  end
end
