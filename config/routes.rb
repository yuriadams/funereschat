Rails.application.routes.draw do
  resources :lobby, only: [:index, :show]

  root 'sessions#index'
end
