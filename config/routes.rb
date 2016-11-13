Rails.application.routes.draw do
  devise_for :users
  root to: 'application#index'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'

  resources :users, only: [] do
    collection do
      post :become_mediator
      get :public_keys
    end
  end

  resources :transactions do
    member do
      get :start
      post :save_initialized
      get :pay
      put :cancel
      put :complete
    end
  end
end
