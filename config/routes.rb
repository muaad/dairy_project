Rails.application.routes.draw do
  resources :payments

  resources :prices

  resources :deliveries

  resources :commodities

  resources :farmers

  root to: 'home#index'
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :users

  get "dashboard/index"
  get "dashboard/farmers"
  get "dashboard/deliveries"
  get "dashboard/settings"
  get "dashboard/reports"
  get "dashboard/users"
  get "dashboard/notifications"

  match "delivery/:id/pay" => "deliveries#make_payment", :as => "pay_delivery", via: [:post]

  post "/users/add_user" => "users#create", :as => "add_user"
end
