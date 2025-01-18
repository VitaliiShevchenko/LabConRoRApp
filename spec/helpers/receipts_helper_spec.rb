require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReceiptsHelper. For example:
#
# describe ReceiptsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReceiptsHelper, type: :helper do
  describe '#select_material' do
  let(:supplier) { Supplier.create name: 'Supplier Name', active: nil, id: 1 }
  let(:material) { Material.create name: 'Material',      description: 'Material Description',   price: 10.00,
                                    note: 'Material Note', supplier_id: supplier[:id], id: 1, available: nil }

  context 'when supplier is active and material is available' do
    it 'returns selected material in array format' do
      supplier[:active] = true
      material[:available] = true
      supplier.save
      material.save
      expect(helper.select_material).to eq [ [ "#{material[:name]} | #{supplier[:name]}", material[:id] ] ]
    end
  end

  context 'when supplier is active and material is not available' do
    it 'returns empty array' do
      supplier[:active] = true
      material[:available] = false
      supplier.save
      material.save
      expect(helper.select_material).to eq []
    end
  end

  context 'when supplier is not active and material is available' do
    it 'returns empty array' do
      supplier[:active] = false
      material[:available] = true
      supplier.save
      material.save
      expect(helper.select_material).to eq []
    end
  end
  end

  describe "#to_double_namw" do
    let(:supplier) { Supplier.create name: 'Supplier Name', active: nil, id: 1 }
    let(:material) { Material.create name: 'Material',  description: 'Material Description',   price: 10.00,
                                     note: 'Material Note', supplier_id: supplier[:id], id: 1, available: nil }

    context 'when material is exist' do
      it "converts material_id to special double name" do
        supplier.save
        material.save
        expect(helper.to_double_name(material[:id])).to eq "#{material.name} | #{supplier.name}"
      end
    end

    context "when material isn't exist" do
      it "return nil" do
        supplier.save
        material.save
        expect(helper.to_double_name(0)).to eq nil
      end
    end
  end
end
