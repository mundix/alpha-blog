Rails.application.routes.draw do

  root 'pages#home'

  get 'pages/home', to: 'pages#home'
  get 'pages/about', to: 'pages#about'

  resources :articles #CRUD paths

  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
#   Otra forma de hacelro es usando
  resources :users, except: [:new]

  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'

  resources :categories, except: [:destroy]

end
