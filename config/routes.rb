Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "signup", to: "auth#signup"
      post "login", to: "auth#login"
      delete "logout", to: "auth#logout"

      resources :jobs, only: [:index, :show, :create, :update, :destroy] do
        resources :applications, only: [:index, :create]
      end

      resources :applications, only: [:show, :update, :destroy]

      resources :trainings, only: [:index, :show, :create, :update, :destroy] do
        resources :training_registrations, only: [:index, :create], path: "registrations"
      end

      resources :students, only: [:show, :update] do
        resources :skills, only: [:index, :create], controller: "student_skills"
      end

      resources :companies, only: [:index, :show, :update]
      resources :trainers, only: [:index, :show, :update]
      resources :categories, only: [:index, :create]
      resources :skills, only: [:index, :create]

      resources :messages, only: [:index, :create, :show]
      resources :notifications, only: [:index, :update]

      namespace :admin do
        resources :users, only: [:index, :update, :destroy]
        resources :companies, only: [:index, :update] # validation des entreprises
      end
    end
  end
end
