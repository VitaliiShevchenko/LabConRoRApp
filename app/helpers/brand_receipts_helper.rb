module BrandReceiptsHelper
  def is_deletion_restrict?(brand_receipt_id)
    brand_receipt = BrandReceipt.find(brand_receipt_id)
    brand_receipt.receipts.count >= 1
  end
end
