Rails.application.routes.draw do

  root to: "user_sessions#new"

  namespace :api do
    namespace :v1 do
      get 'sessions/create'
      get 'sessions/destroy'
      get 'tasks/index'
      post 'tasks/create'
      put 'tasks/:id/update', to: 'tasks#update'
      get '/show/:id', to: 'tasks#show'
      post 'tasks/fetch_tasks',  defaults: { format: 'json' }
      post 'tasks/fetch_task_status'
      delete 'tasks/destroy/:id', to: 'tasks#destroy',  defaults: { format: 'json' }
    end
  end

  namespace :api do
    namespace :v1 do
      post 'users/create'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  resources :users
  resources :user_sessions
  resources :tasks do
    collection do
      get :fetch_tasks
    end
  end

end
