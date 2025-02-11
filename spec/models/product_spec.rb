require 'rails_helper'


RSpec.describe Product, type: :model do
  describe "validations" do
    let!(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.build(:product, user: user) }

    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it "is invalid without a name" do
      product.name = nil
      expect(product).to_not be_valid
    end

    it "is invalid without a price" do
      product.price = nil
      expect(product).to_not be_valid
    end

    it "is invalid if price is 0 or negative" do
      product.price = 0
      expect(product).to_not be_valid
    end

    it "is invalid if stock is negative" do
      product.stock_quantity = -5
      expect(product).to_not be_valid
    end
  end
end
