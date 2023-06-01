Rails.application.routes.draw do
  resources :categories
  resources :reviews
  resources :carts
  resources :products
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"
end
