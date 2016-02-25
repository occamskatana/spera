Rails.application.routes.draw do
 

  get 'events/create'

  get 'friendables/friend_request'

  root to: 'welcome#index'
  
  devise_for :users, controllers: {registrations: 'registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  resources :users, only: [:show] do 
    resources :goals
    resources :checkins, only: []
    resources :events, only: [:create]
  end

  resources :friendable, defaults: {format: 'json'} do
    member do 
      put 'friend_request' 
    end 
  end

  resources :friendables do
    member do
      put 'friend_request'
      put 'friend_request_accept'
      delete 'friend_request_reject'
    end
end

  namespace :api do 
  	namespace :v1 do 
  		resources :users, only: [:show, :index] do 
        get 'friend_list'
        resources :checkins, only: [:show, :index] 
      end
      resources :friendables, only: [:show, :index]
  		resources :goals
      resources :events, only: [:index] 
      resources :checkins, only: [:show, :create, :index]
      resources :notifications, only: [:index, :update]
      resources :boards do
        resources :posts
      end
  	end
  end

  

  
end
