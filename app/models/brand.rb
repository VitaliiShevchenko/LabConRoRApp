class Brand < ApplicationRecord
  belongs_to :creator
  has_many :brand_receipt
end
