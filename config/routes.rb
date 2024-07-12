Rails.application.routes.draw do
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    resource :password_reset,     only: [:new, :edit, :create, :update]
  end
  root "home#index"
  # root "genki#index"

  resources :workouts
  resources :nutrition
  resources :stats 
  resources :tools
  resources :coach
  resources :exercises do
  patch :update_status, on: :member
end


  get "statsdata", to: 'stats#statsdata'
  get "reminders", to: 'coach#reminders'

end
