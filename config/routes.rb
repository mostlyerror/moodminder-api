Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      # User registration
      post "users/register", to: "users#register"
      post "users/unregister", to: "users#unregister"

      # Webhook routes
      post "webhooks/twilio_sms", to: "webhooks#twilio_sms"
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
