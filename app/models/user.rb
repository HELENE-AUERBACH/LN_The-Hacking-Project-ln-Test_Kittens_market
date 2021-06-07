class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[^@\s]+@yopmail\.com\z/i, message: " : Recheck your email adress please!" }
  validates :encrypted_password,
            presence: true,
            length: { minimum: 6 }
end
