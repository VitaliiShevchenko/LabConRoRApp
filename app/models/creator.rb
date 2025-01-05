class Creator < ApplicationRecord
  belongs_to :user
  has_many   :brands
  has_many   :tests

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :user_id,  uniqueness: true
  validates :phone,      presence: true

  def self.ransackable_associations(auth_object = nil)
    ["brands", "tests", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "first_name", "id", "last_name", "order_description", "phone", "position", "updated_at", "user_id"]
  end
end
