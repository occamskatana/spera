Rails.application.routes.draw do
 

  root to: 'welcome#index'
  
  devise_for :users, controllers: {registrations: 'registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  resources :users, only: [:show] do 
    resources :goals
    resources :checkins, only: []
  end

  namespace :api do 
  	namespace :v1 do 
  		resources :users, only: [:show]
  		resources :goals
      resources :checkins, only: [:show, :create]
  	end
  end

  

  
end
