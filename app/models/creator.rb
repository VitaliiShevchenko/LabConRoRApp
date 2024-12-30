class Creator < ApplicationRecord
  belongs_to :user
  has_many   :brands
  has_many   :tests
end
