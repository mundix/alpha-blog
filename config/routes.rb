Rails.application.routes.draw do

  root 'pages#home'

  get 'pages/home', to: 'pages#home'
  get 'pages/about', to: 'pages#about'

  resources :articles #CRUD paths

  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
#   Otra forma de hacelro es usando
  resources :users, except: [:new]
end
