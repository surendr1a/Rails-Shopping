class BusinessProfile < ApplicationRecord
  belongs_to :user

  # Validations
  validates :business_name, presence: true
  validates :contact_number, presence: true
end
