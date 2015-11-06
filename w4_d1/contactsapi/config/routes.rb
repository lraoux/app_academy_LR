Rails.application.routes.draw do
  # get 'users/' => 'users#index'
  # post 'users/' => 'users#create'
  # get 'users/:id' => 'users#show', :as => 'user'
  # get 'users/:id/edit' => 'users#edit', :as => 'edit_user'
  # get 'users/new' => 'users#new', :as => 'new_user'
  # delete 'users/:id' => 'users#destroy'
  # put 'users/:id' => 'users#update'
  # patch 'users/:id' => 'users#update'
  resources :users do
    resources :contacts, only: :index
  end

  resources :users, only: [:create, :destroy, :index, :show, :update]
  resources :contacts, only: [:create, :destroy, :show, :update]
  resources :contact_shares, only: [:create, :destroy]
end
