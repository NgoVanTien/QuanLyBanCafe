Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root 'static_pages#index'
    resources :products
    resources :categories
    resources :tables
    resources :reports
    namespace :ajax do
      resources :products_orders
      resources :orders_reports
    end
  end
end
