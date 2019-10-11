Rails.application.routes.draw do
  root to: 'pictures#index'
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  get '/index', to: 'pictures#index'
  post '/pictures', to: 'pictures#confirm'
end
