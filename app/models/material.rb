class Material < ApplicationRecord
  belongs_to :supplier

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :note, presence: true
end
