Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#top"

  get 'home/about'

  resources :recipes, only: [:create, :index, :show, :update, :edit, :destroy]
  resources :users, only: [:show, :edit, :index, :update]
end
