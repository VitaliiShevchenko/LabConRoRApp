class Test < ApplicationRecord
  belongs_to :brand_receipt
  belongs_to :creator
  has_many   :data_flows
end
