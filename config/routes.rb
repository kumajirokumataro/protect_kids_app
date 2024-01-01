Rails.application.routes.draw do
  get 'top/index'
  root 'top#index'
  resources :posts
  #get "/" => "tasks#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  #namespace :admin do
    #resources :users
  #end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
