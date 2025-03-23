Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resource :api do
    resource :v1 do
      resources :users, controller: 'api/v1/users', only: [] do
        post  :deposit_money
        post  :withdraw_money
        post  :transfer_money
        get   :wallet_balance
        get   :wallet_history
      end
    end
  end
end
