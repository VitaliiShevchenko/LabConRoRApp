class Supplier < ApplicationRecord
  has_many :material, dependent: :restrict_with_error
end
