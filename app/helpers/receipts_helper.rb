# frozen_string_literal: true

module ReceiptsHelper
  def select_material
    array = []
    Supplier.active.each do |sup|
      sup.material.get_available_materials.each do |material|
        array << [ material.name, material.id ]
      end
    end

    array
  end
end
