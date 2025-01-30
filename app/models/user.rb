class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  # belongs_to :role
  has_many :orders, dependent: :destroy
  has_many :reviews, class_name: 'ProductReview', dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :products, through: :wishlists

  # def set_default_role
  #   self.role ||= 'user'  # Default role to 'user'
  # end

  # Validations
  # validates :email, presence: true, uniqueness: true
  # validates :password, length: { minimum: 6 }, if: :password
end


