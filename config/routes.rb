Rails.application.routes.draw do
  resources :payments

  resources :prices

  resources :deliveries

  resources :commodities

  resources :farmers

  resources :accounts

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
  get "dashboard/account"

  get "/account/setup" => "accounts#set_up", as: "account_set_up", via: [:get]

  match "delivery/:id/pay" => "deliveries#make_payment", :as => "pay_delivery", via: [:post]
  match "deliveries/pay" => "deliveries#bulk_payment", :as => "bulk_payment", via: [:post]

  post "/users/add_user" => "users#create", :as => "add_user"
end
