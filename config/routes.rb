Rails.application.routes.draw do
  resources :lobby, only: [:index, :show]

  resources :sessions, only: [:create, :destroy]

  root 'sessions#index'
end
