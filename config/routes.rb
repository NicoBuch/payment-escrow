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

  resources :transactions
end
