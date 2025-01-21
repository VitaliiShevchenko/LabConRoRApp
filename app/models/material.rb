class Material < ApplicationRecord
  belongs_to :supplier
  has_many   :receipts

  validates :name, presence: true
  validates :price, :density, presence: true, numericality: { greater_than: 0 }


  def self.get_available_materials
    where available: true
  end
end
