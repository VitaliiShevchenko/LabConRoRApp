class Receipt < ApplicationRecord
  belongs_to :brand_receipt
  belongs_to :material
end
