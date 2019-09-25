Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  get 'home/about'

  devise_for :users
  resources :users, only:[:index, :show, :edit, :update]
  resources :books


end
