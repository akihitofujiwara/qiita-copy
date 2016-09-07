Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations'
  }

  root to: "home#index"
  get :items, to: "home#items"
  get :stocks, to: "home#stocks"
  get :mines, to: "home#mines"

  resources :items, only: %i(new edit create update destroy) do
    resource :stock, only: %i(create destroy)
    resources :comments, only: %i(create destroy)
  end

  resources :users, only: %i(show) do
    resources :items, only: %i(show)
    resource :following, only: %i(create destroy)
  end

  resources :tags, only: %i(show) do
    resource :following, only: %i(create destroy)
  end
end
