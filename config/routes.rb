Rails.application.routes.draw do

  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :users, only: [:show]
  resources :posts

  resources :posts do
    resources :likes
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  resources :dashboard, only: [:index]

  # Root route
  root "posts#index"
end
