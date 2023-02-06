Rails.application.routes.draw do
  patch 'books/:id' => 'books#update', as: 'update_book'
  root to: "homes#top"
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:new, :index, :show, :create, :edit, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
