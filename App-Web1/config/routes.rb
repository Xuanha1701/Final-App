Rails.application.routes.draw do

  root 'home#index'
  get 'users/:id/following', to: 'users#following' ,as: :following
  get 'users/:id/unfollowers', to: 'users#followers',as: :followers

  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:new, :create, :show, :destroy] do
    resources :likes
    resources :comments
  end
  resources :follows, only: [:create, :destroy]

  get 'search' => 'search#index'
end
