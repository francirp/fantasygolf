Rails.application.routes.draw do
  resources :leagues

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'marketing#home'

  get '/dashboard' => 'pages#dashboard'

end
