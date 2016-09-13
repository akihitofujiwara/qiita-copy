Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations'
  }

  root to: "home#index"
  get :all_items, to: "home#all_items"
  get :stocks, to: "home#stocks"
  get :mines, to: "home#mines"
  post :md2html, to: "items#md2html"

  resources :items, only: %i(new edit create update destroy) do
    get :draft, on: :collection
    get :search, on: :collection
    resource :stock, only: %i(create destroy)
    resources :comments, only: %i(create destroy)
  end

  resources :users, only: %i(show) do
    delete :twitter, on: :collection, to: "users#unlink_twitter"
    resources :items, only: %i(show)
    resource :following, only: %i(create destroy)
  end

  resources :tags, only: %i(show) do
    resource :following, only: %i(create destroy)
  end
end
