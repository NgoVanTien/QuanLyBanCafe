Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
    root 'static_pages#index'
    resources :products
    resources :categories
    resources :tables
    namespace :ajax do
      resources :products_orders
    end
  end
end
