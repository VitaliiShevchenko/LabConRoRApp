class Brand < ApplicationRecord
  belongs_to :creator
  has_many :brand_receipts

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "creator_id", "updated_at", "name", "desc", "intended_use", "calculated_cost"]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[creator brand_receipts]
  end
end
