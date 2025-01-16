class Material < ApplicationRecord
  belongs_to :supplier

  validates :name, presence: true
  validates :price, presence: true
end
