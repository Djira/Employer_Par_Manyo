Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  resources :users, except: %i(index, destroy)
  resources :sessions, only: %i(new create destroy)
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end