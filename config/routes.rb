Rails.application.routes.draw do
  root to: 'home#index'

  # Devise routes for user authentication
  devise_for :users, controllers: {
    registrations: "users/registrations",
    session: "users/sessions",
  }

  # User Dashboard route
  get '/dashboard', to: 'dashboard#show', as: 'dashboard'
   get '/panel', to: 'dashboard#panel'
   
   post 'create_order', to: 'payments#create'
   post 'verify_payment', to: 'payments#verify'


  # Product-related routes
  resources :products do
    post 'add_to_cart', on: :collection
      resources :reviews, only: [:create, :index]
  end
  post 'cart/add_item', to: 'carts#add_item', as: 'add_item_cart'

post 'cart/place_order', to: 'orders#create', as: 'place_order'

resources :carts, only: [:index, :show, :create] do
  delete 'remove_item/:cart_item_id', to: 'carts#remove_item', as: :remove_item
end
# delete '/carts/:id/remove_item', to: 'carts#remove_item', as: 'remove_item_cart'


  resources :cart_items, only: [:create, :destroy]

  resources :users, only: [:show] do
    get 'profile', on: :collection, to: 'users#show'
  end
  resources :orders
  
  get '404', :to => 'application#page_not_found'
end
