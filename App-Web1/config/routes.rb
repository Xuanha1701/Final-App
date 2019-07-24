Rails.application.routes.draw do

  root 'home#index'
  get 'users/:id/following', to: 'users#following', as: :following
  get 'users/:id/unfollowers', to: 'users#followers', as: :followers
  get 'edit_profile', to: 'users#edit', as: :edit_profile
  get 'profile/me', to: 'users#myprofile', as: :'profile/me'

  namespace :admin do
    resources :photos
    resources :albums
    root to: "photos#index"
  end
  devise_for :users do
    get '/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show, :update, :destroy] do
  end
  resources :posts, only: [:new, :create, :show, :destroy] do
    resources :comments
  end

  resources :follows, only: [:create, :destroy]
  resources :photos, only: [:new, :create, :show, :destroy] do
    post :likes
    delete :unlike
    get :get_photo
  end
  resources :albums, only: [:new, :create, :show, :destroy]

  get 'search' => 'search#index'
end
