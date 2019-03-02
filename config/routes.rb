Rails.application.routes.draw do
  root :to => 'toppages#index'
  resources :user_sessions
  resources :users
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  resources :messages, only: [:index, :show, :new, :create]

end

