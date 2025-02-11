require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "validations" do

    it "is invalid without a user_id" do
      cart = Cart.new(status: "pending")
      expect(cart).to_not be_valid
    end

    it "is invalid without a status" do
      user = User.create(email: "test@example.com", password: "password")
      cart = Cart.new(user_id: user.id)
      expect(cart).to_not be_valid
    end

    it "is invalid with an unknown status" do
      user = User.create(email: "test@example.com", password: "password")
      cart = Cart.new(user_id: user.id, status: "unknown_status")
      expect(cart).to_not be_valid
    end
  end

  
end
