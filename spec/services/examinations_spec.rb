require 'rails_helper'

RSpec.describe DataflowService do
  describe ".create_update_record" do
    let!(:user) { User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let!(:creator) { Creator.create(first_name: "name", last_name: "last_name", user_id: user.id, phone: '555-555-5555') }
    let!(:brand) { Brand.create(name: "Brand", creator_id: creator.id) }
    let!(:brand_receipts) { BrandReceipt.create(brand_id: brand.id) }
    let!(:test1) { Test.create(creator_id: creator.id, brand_receipt_id: brand_receipts.id) }
    let!(:dataflow) { DataFlow.create(test_id: test1.id, testing_time: 1, torque: nil, voltage: nil) }
    let(:measured_parameters) { { torque: 200, voltage: 220 } }
    let(:testing_time) { 0 }
    let(:test_id) { test1.id }

    it "creates a data flow record when no existing record is found" do
      expect {
        DataflowService.create_update_record(test_id, measured_parameters, testing_time)
      }.to change { DataFlow.count }.by(1)
    end

    it "updates a data flow record when a record is found" do
      testing_time = 1
      expect {
        DataflowService.create_update_record(test_id, measured_parameters, testing_time)
      }.to change { DataFlow.last[:torque] }.from(nil).to(measured_parameters[:torque])
    end
  end
end

