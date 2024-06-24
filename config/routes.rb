Rails.application.routes.draw do
  root "genki#index"

  resources :workouts
end
