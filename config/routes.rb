Rails.application.routes.draw do
  get '/', to: "plans#all", as: 'root'
  get '/login', to: "auth#login"
  get '/teachers/login', to: "auth#login_teacher"
  post 'login', to: "auth#check_user"
  post '/teachers/login', to: "auth#check_teacher"
  resources :users
  resources :plans
  resources :teachers
end
