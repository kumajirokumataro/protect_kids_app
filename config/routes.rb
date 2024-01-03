Rails.application.routes.draw do
  get 'top/index'
  root 'top#index'
  resources :posts do
    resources :comments
  end

  #get "/" => "tasks#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  #namespace :admin do
    #resources :users
  #end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
