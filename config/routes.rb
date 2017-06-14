Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users
  resources :hospitals

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

  get "/users/add_patient/:id", to: "users#add_patient"
  get "/users/accept_request/:id", to: "users#accept_request"
  get "/users/add_to_hospital/:id", to: "hospitals#add_to_hospital"
  get "/users/accept_hospital/:id", to: "hospitals#accept_hospital"
  get "/users/deny_hospital", to: "hospitals#deny_hospital"
  get "/personal_page_:id", to: "users#personal_page"

  root "years#index"
end
