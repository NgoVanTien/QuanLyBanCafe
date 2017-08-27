Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
    root 'static_pages#index'

    get 'static_pages/show'

    get 'static_pages/home'
  end
end
