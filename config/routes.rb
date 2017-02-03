Rails.application.routes.draw do
  resources :contact_messages, only: [:new, :create]
  get 'home_page/index'
  get 'browse', to: 'home_page#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :locations, only: [:show, :new, :create] do
    resources :reviews, only: [:create, :index]
  end
  resources :posts, only: [:show, :index]

  get 'states/:state_alpha2/locations' => 'locations#index', as: 'state_locations'

  get 'categories/:blog_category_id' => 'posts#index', as: 'blog_category'

  get '/sitemap.xml.gz', to: redirect('http://america-hunt-dev.s3.amazonaws.com/sitemaps/sitemap.xml.gz'), as: :sitemap

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Avocado::Engine => '/avocado'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: 'home_page#new_home'

  get ':id' => 'pages#show', as: :page
end
