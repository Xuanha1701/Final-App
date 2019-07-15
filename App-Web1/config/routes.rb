Rails.application.routes.draw do

  post '/follow_user', to: 'relationships#follow_user', as: :follow_user
  post '/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get 'users/:id/following', to: 'users#following' ,as: :following
  get 'users/:id/unfollowers', to: 'users#followers',as: :followers
  get 'search/index'
  root 'home#index'
  # resources :users do
  #   member do
  #     get :following, :followers
  #   end
  # end
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:new, :create, :show, :destroy]
  resources :follows, only: [:create, :destroy]

  get 'search' => 'search#index'
end
