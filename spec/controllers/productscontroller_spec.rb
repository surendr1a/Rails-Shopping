require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:product) { create(:product, user: user, category: category) }

  before do
    sign_in user 
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    context "when product exists" do
      it "returns a success response" do
        get :show, params: { id: product.id }
        expect(response).to be_successful
      end
    end

    context "when product does not exist" do
      it "redirects to products path with an alert" do
        get :show, params: { id: 9999 }
        expect(response).to redirect_to(products_path)
        expect(flash[:alert]).to eq("Product not found.")
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new product" do
        expect {
          post :create, params: { product: attributes_for(:product, user_id: user.id, category_id: category.id) }
        }.to change(Product, :count).by(1)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a product and re-renders the form" do
        expect {
          post :create, params: { product: { name: "", description: "", price: 0 } }
        }.to_not change(Product, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is authorized" do
      it "updates the product" do
        patch :update, params: { id: product.id, product: { name: "Updated Name" } }
        expect(product.reload.name).to eq("Updated Name")
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when user is unauthorized" do
      let(:other_user) { create(:user) }
      let(:other_product) { create(:product, user: other_user) }

      it "does not update the product and redirects" do
        patch :update, params: { id: other_product.id, product: { name: "Hacked Name" } }
        expect(other_product.reload.name).not_to eq("Hacked Name")
        expect(response).to redirect_to(products_path)
        expect(flash[:alert]).to eq("You are not authorized to edit this product.")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is authorized" do
      it "deletes the product" do
        product # Ensure product is created before deletion
        expect {
          delete :destroy, params: { id: product.id }
        }.to change(Product, :count).by(-1)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when user is unauthorized" do
      let(:other_user) { create(:user) }
      let(:other_product) { create(:product, user: other_user) }

      it "does not delete the product and redirects" do
        delete :destroy, params: { id: other_product.id }
        expect(Product.exists?(other_product.id)).to be_truthy
        expect(response).to redirect_to(products_path)
        expect(flash[:alert]).to eq("You are not authorized to delete this product.")
      end
    end
  end
end
