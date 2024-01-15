Rails.application.routes.draw do
  devise_for :users
  root to: "tables#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tables, only: [:index, :show, :edit, :update] do
    member do
      match 'close', to: 'tables#close', via: [:get, :post]

    end
    resources :orders, only: [:create, :new, :edit]
    member do
      get 'checkout', to: 'tables#checkout'
    end
  end
  resources :orders, only: [:index, :destroy], shallow: true do
    resources :selected_foods, only: [:create, :destroy]
  end
  get 'tables/:id/all_orders', to: 'tables#all_orders', as: :all_orders

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index
end
