Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }

  # Root route
  root "products#index" 

  resources :products, only: [:index, :show]
  resources :carts, only: [:show]
  resources :cart_items, only: [:create, :destroy]
  resources :product_categories, only: [:index, :show]
  resources :orders, only: [:index, :show, :create]
  resources :product_reviews, only: [:create, :destroy]
  resources :wishlists, only: [:index, :create, :destroy]
  get "up" => "rails/health#show", as: :rails_health_check

  # Optional: Routes for PWA (Progressive Web App) manifest and service worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Additional Routes for any other resources can be added here
end
