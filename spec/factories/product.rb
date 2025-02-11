# This will guess the product class


FactoryBot.define do
  factory :product do
    name { "Laptop" }
    price { 50000 }
    stock_quantity { 10 }
    user { association :user } 
    # user
  end

end
