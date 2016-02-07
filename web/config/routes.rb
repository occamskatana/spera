Rails.application.routes.draw do
 

  root to: 'welcome#index'
  
  devise_for :users, controllers: {registrations: 'registrations', passwords: 'users/passwords', sessions: 'users/sessions' }

  resources :users, only: [:show] do 
    resources :goals
  end

  

  
end
