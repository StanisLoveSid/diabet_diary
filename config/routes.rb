Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :years do
    resources :comments, module: :years
    resources :months do
    resources :comments, module: :months      
      resources :days do
        resources :comments, module: :days
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
