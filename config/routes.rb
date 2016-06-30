Rails.application.routes.draw do
  resources :locations
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Avocado::Engine => '/avocado'

  # devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  namespace :api, defaults: { format: :json } do
    # devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }
  end

  root to: 'users#profile'
end
