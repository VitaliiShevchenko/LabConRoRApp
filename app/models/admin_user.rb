class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  MAX_NAME_LENGTH = 100
  validates :name, length: { maximum: MAX_NAME_LENGTH }, presence: true, default: ""
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: MAX_NAME_LENGTH }
  validates :password, length: { minimum: 6 }, presence: true
end
