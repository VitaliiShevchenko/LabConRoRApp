class Receipt < ApplicationRecord
  belongs_to :brand_receipt
  belongs_to :material

  def join_mt_sp_names
    material = Material.find(self.material_id)
    supplier = material.supplier
    "#{material.name} | #{supplier.name}"
  end
end
