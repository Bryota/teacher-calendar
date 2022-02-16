Rails.application.routes.draw do
  devise_for :tests
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/', to: "plans#all", as: 'root'
  get '/login', to: "auth#login"
  get '/teachers/login', to: "auth#login_teacher"
  post 'login', to: "auth#check_user"
  post '/teachers/login', to: "auth#check_teacher"
  post '/plans/:id/cancel', to: "plans#cancel", as: 'cancel_plan'
  resources :users
  resources :plans
  resources :teachers
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :teacher_password_resets, only: [:new, :create, :edit, :update]
end
