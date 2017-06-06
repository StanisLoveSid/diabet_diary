Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :years do
    resources :months do
      resources :days do
        resources :sugar_levels
        resources :meals
        resources :exercises
        resources :warnings
        resources :insulin_injections
      end
    end
  end

  root "years#index"
end
