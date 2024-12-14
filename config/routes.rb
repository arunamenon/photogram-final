Rails.application.routes.draw do
  devise_for :users
  
  # Public accessible routes (indexes)
  resources :users, only: [:index, :show]
  resources :photos
  resources :comments, only: [:create, :destroy, :index, :show]
  resources :likes, only: [:create, :destroy]
  resources :follow_requests, only: [:create, :destroy, :update, :index]

  # Root route
  root "photos#index"
end
