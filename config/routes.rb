Rails.application.routes.draw do
  # Devise routes for authentication (sign_in, sign_out, sign_up, etc.)
  devise_for :users

  # Set the root path to an action that can be visited while signed out
  root "users#index"

  # Users listing and custom show by username
  get "/users", to: "users#index"
  get "/users/:username", to: "users#show", as: :user_profile

  # Additional user-based routes for feed, liked photos, discover
  get "/users/:username/feed",         to: "users#feed",         as: :user_feed
  get "/users/:username/liked_photos", to: "users#liked_photos", as: :user_liked_photos
  get "/users/:username/discover",     to: "users#discover",     as: :user_discover

  # Resourceful routes for photos, comments, likes, follow requests
  # (Skipping :new and :edit if the forms are embedded in index/show pages.)
  resources :photos, except: [:new, :edit]
  resources :comments, except: [:new, :edit]
  resources :likes, except: [:new, :edit]
  resources :follow_requests, except: [:new, :edit]
end
