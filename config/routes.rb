Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login', to: 'accounts#login'
  post '/forgot_password', to: 'accounts#forgot_password'
  post '/reset_password', to: 'accounts#reset_password'

  post '/apply_leave', to: 'leaves#apply_leave'
end
