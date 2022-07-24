Rails.application.routes.draw do
  root "application#index"

  resources :books, only: :index
  resources :rankings, only: :create
end
