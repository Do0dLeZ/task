Rails.application.routes.draw do
  root 'welcome#index'

  resources :tasks
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',    to: 'users#new',              via: 'get'
  match '/signin',    to: 'sessions#new',           via: 'get'
  match '/signout',   to: 'sessions#destroy',       via: 'delete'

end
