class AddColumnDensityToMaterials < ActiveRecord::Migration[7.2]
  def change
    add_column :materials, :density, :float
  end
end
