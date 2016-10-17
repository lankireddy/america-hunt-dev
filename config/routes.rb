Rails.application.routes.draw do

  resources :contact_messages, only: [:new, :create]
  get 'home_page/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :locations, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:create, :index]
  end
  resources :posts, only: [:show, :index]

  get 'categories/:blog_category_id' => 'posts#index', as: 'blog_category'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Avocado::Engine => '/avocado'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: 'home_page#index'

  get ':id' => 'pages#show', as: :page
end
