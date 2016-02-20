Rails.application.routes.draw do
 

  get 'friendables/friend_request'

  root to: 'welcome#index'
  
  devise_for :users, controllers: {registrations: 'registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  resources :users, only: [:show] do 
    resources :goals
    resources :checkins, only: []
  end

  resources :friendable do
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
        resources :checkins, only: [:show, :index] 
      end
      resources :friendables
  		resources :goals
      resources :checkins, only: [:show, :create, :index]
  	end
  end

  

  
end
