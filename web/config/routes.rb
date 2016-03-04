Rails.application.routes.draw do
 

  get 'events/create'

  get 'friendables/friend_request'

  root to: 'welcome#index'
  
  devise_for :users, controllers: {registrations: 'registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  resources :users, only: [:show] do 
    resources :goals
    resources :checkins, only: []
    # resources :events, only: [:create]
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
  		resources :goals do
        resources :objectives, only: [:index, :create]
      end
      resources :events, only: [:index, :create] 
      resources :checkins, only: [:show, :create, :index]
      resources :notifications, only: [:index, :update]
      resources :boards do
        post '/up-vote' => 'votes#up_vote', as: :up_vote
        post '/down-vote' => 'votes#down_vote', as: :down_vote
        resources :posts 
        
      end
  	end
  end

  

  
end
