class Material < ApplicationRecord
  belongs_to :supplier

  validates :name, presence: true
  validates :price, presence: true


  def self.get_available_materials
    where available: true
  end
end
