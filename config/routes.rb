require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :products do
    resources :reviews, only: [:create]
    get 'search', on: :collection
  end


  resource :cart, only: [:show] do
    post '/add', to: 'carts#add', as: 'add_to_cart'
    delete '/remove/:id', to: 'carts#remove', as: 'remove_from_cart'
  end


  root "products#index"

  patch 'change_locale' => 'locales#change_locale'



  mount Sidekiq::Web => '/sidekiq'
end
