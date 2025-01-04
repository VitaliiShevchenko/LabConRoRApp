class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :creator

  def self.ransackable_associations(auth_object = nil)
    ["creator"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id"]
  end
end
