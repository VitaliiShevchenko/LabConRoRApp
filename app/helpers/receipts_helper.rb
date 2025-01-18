# frozen_string_literal: true

module ReceiptsHelper
  def select_material
    array = []
    Supplier.active.each do |sup|
      sup.material.get_available_materials.each do |material|
        array << [ "#{material.name} | #{sup.name}", material.id ]
      end
    end

    array
  end

  def to_double_name(material_id)
    begin
      material = Material.find(material_id)
      supplier = material.supplier
      "#{material.name} | #{supplier.name}"
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = e.message
      nil
    end
  end
end
