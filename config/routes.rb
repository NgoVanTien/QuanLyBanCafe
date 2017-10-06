Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root 'static_pages#index'
    resources :products
    resources :categories
    resources :tables
    resources :locations
    resources :reports, only: [:index, :show]
    resources :week_reports, only: [:index]
    resources :month_reports, only: [:index]
    resources :year_reports, only: [:index]
    namespace :ajax do
      resources :products_orders
      resources :orders_reports
      resources :week_reports
      resources :area_locations
    end
  end
end
