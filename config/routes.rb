Rails.application.routes.draw do
  root to: 'home#index'  # Home page route
  
  # User-related routes (Devise should handle sign in, sign up, etc.)
  devise_for :users
  
  # Product-related routes
  resources :products do
    resources :product_reviews, only: [:create]  # Nested route for product reviews
  end

  # Cart routes
  resources :carts, only: [:index, :show]  # For displaying cart and its details

  # Cart Items (For adding/removing/updating individual cart items)
  resources :cart_items, only: [:create, :destroy] do
    member do
      patch 'update_item'  # For updating quantity or other attributes of an item
    end
  end
  
  # Order routes
  resources :orders
  
  # Business profiles routes
  resources :business_profiles
  
  # Wishlist routes
  resources :wishlists, only: [:show, :create, :destroy]  # Adding, showing, and removing items
  
  # Categories and Discounts routes
  resources :categories, only: [:index, :show]
  resources :discounts, only: [:index, :show]
 
  resources :users, only: [:show] do
    collection do
      get 'profile', to: 'users#show'
    end
  end
  # Admin routes
  namespace :admin do
    resources :products, :orders
  end
end
