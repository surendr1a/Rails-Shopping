require 'rails_helper'

RSpec.describe "Products API", type: :request do
  let!(:products) { create_list(:product, 3) } # FactoryBot se 3 products create
  let(:product_id) { products.first.id } # Pehla product ka ID

  describe "GET /products" do
    it "returns all products" do
      get "/products"
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /products/:id" do
    it "returns the product" do
      get "/products/#{product_id}"
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(product_id)
    end

    it "returns 404 if product not found" do
      get "/products/99999"
      
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /products" do
    let(:valid_attributes) { { name: "New Product", price: 100, stock: 10 } }

    it "creates a new product" do
      post "/products", params: { product: valid_attributes }
      
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("New Product")
    end

    it "returns error if data is invalid" do
      post "/products", params: { product: { name: "" } } # Invalid data
      
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /products/:id" do
    let(:updated_attributes) { { name: "Updated Product" } }

    it "updates the product" do
      put "/products/#{product_id}", params: { product: updated_attributes }
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq("Updated Product")
    end
  end

  describe "DELETE /products/:id" do
    it "deletes the product" do
      delete "/products/#{product_id}"
      
      expect(response).to have_http_status(:no_content)
    end
  end
end
