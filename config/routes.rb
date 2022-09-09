Rails.application.routes.draw do
  root "meetings#index"

  resources :meetings, only: [:index, :create, :destroy] do
    post :book, :unbook, on: :member
    post :cancel, on: :member
  end
  resources :users do
    get :calendar, to: "meetings#user_calendar"
  end
  resources :investors do
    get :calendar, to: "meetings#investor_calendar"
  end
end
