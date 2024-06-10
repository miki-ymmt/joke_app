Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get 'user_sessions/new'
  get 'user_sessions/create'
  delete 'user_sessions/destroy'
  get 'jokes/index'
  get 'jokes/show'
  get 'jokes/new'
  get 'jokes/create'
  delete 'jokes/destroy'
  root 'staticpages#top'
  #resources :tasks
  resources :jokes, only: %i[new create edit update show index destroy]
  resources :users, only: %i[new create show edit update destroy]
  resources :password_resets, only: %i[new create edit update]
  get "login", to: "user_sessions#new" #ログインページ
  post "login", to: "user_sessions#create" #ログイン機能
  delete "logout", to: "user_sessions#destroy"  #ログアウト機能
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
