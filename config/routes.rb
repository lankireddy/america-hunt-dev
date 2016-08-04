Rails.application.routes.draw do

  resources :posts
  get 'home_page/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :locations, only: [:index, :show, :new, :create]
  resources :posts, only: [:show]
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Avocado::Engine => '/avocado'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: 'home_page#index'

  get ':id' => 'pages#show'
end
