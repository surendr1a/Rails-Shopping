class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :products
  has_one :cart, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reviewed_products, through: :reviews, source: :product

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password_required?

  after_create :create_cart

  public

  def create_cart
    self.create_cart!
  end
end
