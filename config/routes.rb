Rails.application.routes.draw do
  get 'jokes/index'
  get 'jokes/show'
  get 'jokes/new'
  get 'jokes/create'
  get 'jokes/destroy'
  root 'staticpages#top'
  #resources :tasks
  resources :jokes, only: %i[new create show index destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
