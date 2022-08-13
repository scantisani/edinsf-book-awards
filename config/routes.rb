Rails.application.routes.draw do
  root "application#index"

  resources :books, only: :index
  resources :rankings, only: :create
  resources :users, only: :show, param: :uuid

  post "logout", to: "users#logout"
end
