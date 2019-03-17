Rails.application.routes.draw do
  root :to => 'toppages#index'
  resources :user_sessions
  resources :users
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  resources :messages, only: [:index, :show, :new, :create]
  resources :lessons, only: [:index, :show, :new, :create, :edit, :update]
  
  resources :points, only: [:index, :new, :create] do
    collection do
      post 'purchase'
    end
  end
end

