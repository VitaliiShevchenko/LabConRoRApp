class RenameDescToDescriptionInMaterialsTable < ActiveRecord::Migration[7.2]
  def change
      rename_column :materials, :desc, :description
  end
end
