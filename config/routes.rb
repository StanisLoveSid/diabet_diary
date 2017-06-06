Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :days do
    resources :sugar_levels
    resources :meals
    resources :exercises
    resources :warnings
    resources :insulin_injections
  end
  root "days#index"
end
