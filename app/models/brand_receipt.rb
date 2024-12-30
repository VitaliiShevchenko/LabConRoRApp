class BrandReceipt < ApplicationRecord
  belongs_to :brand
  has_many   :receipts
  has_many   :tests
end
