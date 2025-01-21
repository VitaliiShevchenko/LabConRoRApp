class Receipt < ApplicationRecord
  belongs_to :brand_receipt
  belongs_to :material

  validates :amount_kg, :sum_s, :volume_cc, presence: true

  def join_mt_sp_names
    return if self.material_id.nil?

    material = Material.find(self.material_id)
    supplier = material.supplier
    "#{material.name} | #{supplier.name}"
  end

  def sum_s
    return if self.amount_kg.nil?

    material = Material.find(self.material_id)
    material.price * amount_kg
  end

  def volume_cc
    return if self.amount_kg.nil?

    material = Material.find(self.material_id)
    material.density * amount_kg
  end
end
