Rails.application.routes.draw do
 
  # Being used?
  get 'events/create'

  # Being used?
  get 'friendables/friend_request'

  # Being used?
  root to: 'welcome#index'
  
  devise_for :users, controllers: {registrations: 'users/registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  # Are these routes being used?
  resources :users, only: [:show] do 
    resources :goals
    resources :checkins, only: []
    # resources :events, only: [:create]
  end

  # Are these routes being used?
  resources :friendable, defaults: {format: 'json'} do
    member do 
      put 'friend_request' 
    end 
  end

  # Are these routes being used?
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
      resources :suggested_objectives, only: [:index]
      
      # These resources needed?
      resources :objectives, only: [] do 
        resources :occurrences, only: [:index]
      end

      resources :occurrences, only: [:index] do 
        put 'mark_complete' => 'occurrences#mark_complete', as: :mark_complete
      end
      resources :events, only: [:index, :create] 
      resources :checkins, only: [:show, :create, :index]
      resources :notifications, only: [:index, :update]
      resources :aboutmes, only: [:index, :create, :update]
      resources :boards do
        post '/up-vote' => 'votes#up_vote', as: :up_vote
        post '/down-vote' => 'votes#down_vote', as: :down_vote
        resources :posts 
      end
      resources :groups, only: [:index, :show, :create]
      resources :chats, only: [:show, :create] do
        resources :messages
      end
      resources :friends, only: [:index, :show]
  	end
  end
 
end
