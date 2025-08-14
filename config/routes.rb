Rails.application.routes.draw do
  resources :users, only: [:index, :show, :create, :update, :destroy]

  resources :wallets, only: [:show, :update] do
    member do
      post :top_up
    end
  end

  resources :transactions, only: [:index, :show]

  resources :subscriptions do
    member do
      post :process_payment
    end
  end
end
