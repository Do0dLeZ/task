Rails.application.routes.draw do
  get 'welcome/index'

  resources :tasks
  resources :users

  root 'welcome#index'
  match '/signup',  to: 'users#new',            via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
