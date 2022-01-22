Rails.application.routes.draw do
  get '/login', to: "auth#login"
  post 'login', to: "auth#check_user"
  resources :users
  resources :plans
end
