class Supplier < ApplicationRecord
  has_many :material, dependent: :restrict_with_error

  def self.active
    where(active: true)
  end
end
