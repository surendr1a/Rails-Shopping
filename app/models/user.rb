class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :orders, dependent: :destroy
  has_many :reviews, class_name: 'ProductReview', dependent: :destroy
  has_many :products
  has_one :cart, dependent: :destroy
  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password_required?

  # Make sure that a cart is created when a user is created
  after_create :create_cart

  public

  def create_cart
    self.create_cart!
  end
end
