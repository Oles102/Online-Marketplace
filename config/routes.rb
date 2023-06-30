Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :products do
    resources :reviews, only: [:create]
  end

  # get 'carts', to: 'carts#show'
  # post 'carts/add'
  # post 'carts/remove'

  # resource :cart, only: [:show] do
  #   post :add, on: :collection
  #   post :remove, on: :collection
  # end
  scope :cart, controller: 'carts' do
    get 'carts', to: 'carts#show'
    post 'carts/add'
    post 'carts/remove'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

  patch 'change_locale' => 'locales#change_locale'
end