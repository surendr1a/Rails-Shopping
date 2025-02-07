require 'rails_helper'


RSpec.describe Product, type: :model do
  it "valid user with all attributes" do
    user = User.new(name: "Surendra", email: "test@example.com", password: "password")
    expect(user).to be_valid
  end

  it "invalid without email" do
    user = User.new(name: "Surendra", password: "password")
    expect(user).to_not be_valid
  end
end
