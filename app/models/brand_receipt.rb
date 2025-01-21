class BrandReceipt < ApplicationRecord
  belongs_to :brand
  has_many   :receipts
  has_many   :tests

  def calculated_cost
    total_s = receipts.inject(0) { |sum, receipt| sum + receipt.sum_s }
    total_kg = receipts.inject(0) { |sum, receipt| sum + receipt.amount_kg }
    return if total_kg.zero?

    total_s / total_kg
  end

  def density
    total_vol = receipts.inject(0) { |sum, receipt| sum + receipt.volume_cc }
    total_kg = receipts.inject(0) { |sum, receipt| sum + receipt.amount_kg }
    return if total_kg.zero?

    total_vol / total_kg
  end
end
