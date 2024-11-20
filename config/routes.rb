Rails.application.routes.draw do
  get 'bookings/new'
  devise_for :users
  root to: "tools#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :tools, only: %i[index show new create listing] do
    resources :bookings
  end

  resources :bookings, only: %i[index show]

  get "/user/listing", to: "tools#listing"
end
