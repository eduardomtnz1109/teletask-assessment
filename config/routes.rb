Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "appointments#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [] do
    member do
      get :start_onboarding
      get :phone_verify
      get :resend_verify_code
      post :process_details
      patch :complete_verification
    end
  end

  resources :appointments do
    member do
      post :approve
      post :decline
    end
  end

  resources :slots
  resources :doctors, only: %i[index show] do
    post 'create_appointment', on: :member
  end
end
