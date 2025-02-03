Rails.application.routes.draw do
  # Root route
  root to: 'home#index'

  # Devise routes for user authentication
  devise_for :users, controllers: {
    registrations: "users/registrations",
    session: "users/sessions",
  }

  # User Dashboard route
  get '/dashboard', to: 'dashboard#show', as: 'dashboard'

  # Product-related routes
  resources :products do
    post 'add_to_cart', on: :collection
  end
  post 'cart/add_item', to: 'carts#add_item', as: 'add_item_cart'

#order 
post 'cart/place_order', to: 'orders#create', as: 'place_order'
resources :orders, only: [:index, :show]

  # Cart-related routes
 # config/routes.rb
resources :carts, only: [:index, :show, :create] do
  delete 'remove_item/:cart_item_id', to: 'carts#remove_item', as: :remove_item
end
# delete '/carts/:id/remove_item', to: 'carts#remove_item', as: 'remove_item_cart'


  # Cart item routes for adding/removing items
  resources :cart_items, only: [:create, :destroy]

  # User profile route
  resources :users, only: [:show] do
    get 'profile', on: :collection, to: 'users#show'
  end
  resources :orders
  
  # Admin namespace for managing products and orders
  # namespace :admin do
  # end
end
