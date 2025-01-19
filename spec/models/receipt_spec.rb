require 'rails_helper'

RSpec.describe Receipt, type: :model do
  describe "#get_material_supplier_str" do
    let(:supplier) { Supplier.create name: 'Supplier Name', active: nil, id: 1 }
    let(:material) { Material.create name: 'Material',  description: 'Material Description',   price: 10.00,
                                     note: 'Material Note', supplier_id: nil, id: 1, available: nil }
    let(:receipt) { Receipt.create material_id: material.id, id: 1 }

    before(:each) do
      supplier.save
    end
    context 'when material_id is exist' do
      it "displays special double name" do
        material[:supplier_id] = supplier[:id]
        material.save
        expect(receipt.join_mt_sp_names).to eq "#{material.name} | #{supplier.name}"
      end
    end

    context "when material_id is nil" do
      it "return nil" do
        receipt[:material_id] = nil
        expect(receipt.join_mt_sp_names ).to eq nil
      end
    end
  end
end
