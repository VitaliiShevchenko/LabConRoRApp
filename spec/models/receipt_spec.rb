require 'rails_helper'

RSpec.describe Receipt, type: :model do
  describe "#join_mt_sp_names" do
    let(:supplier) { Supplier.create name: 'Supplier Name', active: nil }
    let(:material) { Material.create name: 'Material',  description: 'Material Description',   price: 10.00,
                                     density: 20.00, note: 'Material Note', supplier_id: nil, available: nil }
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

  describe ".sum" do
    let!(:supplier) { Supplier.create name: 'Supplier Name', active: nil }
    let!(:material) { Material.create name: 'Material',  description: 'Material Description', density: 6.0, price: 10.00,
                                      available: true, supplier_id: supplier[:id] }
    let!(:receipt) { Receipt.create material_id: material[:id], amount_kg: 50, sum_s: 0 }

    context "when looks intrinsic" do
      it "returns 0.5" do
        expect(receipt.sum_s).to eq 0.5
      end
    end
  end

  describe ".volume_cc" do
    let!(:supplier) { Supplier.create name: 'Supplier Name', active: nil }
    let!(:material) { Material.create name: 'Material',  description: 'Material Description', density: 6.0, price: 10.00,
                                      available: true, supplier_id: supplier[:id] }
    let!(:receipt) { Receipt.create material_id: material[:id], amount_kg: 50, sum_s: 0 }

    context "when looks intrinsic" do
      it "returns 300" do
        expect(receipt.volume_cc).to eq 300
      end
    end
  end
end
