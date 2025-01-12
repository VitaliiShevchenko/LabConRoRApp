class RenameDescToDescriptionInTheBrands < ActiveRecord::Migration[7.2]
  def change
      rename_column :brands, :desc, :description
  end
end
