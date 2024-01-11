Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tables, only: [:index, :show, :edit, :update] do
    member do
      match 'close', to: 'tables#close', via: [:get, :post]
    end
    resources :orders, only: [:create, :new]
    member do
      get 'checkout', to: 'tables#checkout'
    end
    #member do
  # get 'orders/new', to: 'orders#new'
    # patch 'checkout', to: 'tables#checkout'
      #get 'close', to: 'tables#close'
    #end
    #resources :orders, only: [:create]
  end
  resources :orders, only: [:index]
  # Resourceful routes for orders
  #resources :orders, only: [:index, :edit, :update]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index
end
