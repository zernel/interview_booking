Rails.application.routes.draw do
  root "investors#index"

  resources :users do
    get :calendar, to: "meetings#user_calendar"
  end
  resources :investors do
    get :calendar, to: "meetings#investor_calendar"
  end
end
