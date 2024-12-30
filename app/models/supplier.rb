class Supplier < ApplicationRecord
  has_many :material, dependent: :destroy
end
