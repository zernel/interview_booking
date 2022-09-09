Rails.application.routes.draw do
  root "meetings#index"

  resources :users
  resources :investors
end
