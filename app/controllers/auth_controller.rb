class AuthController < ApplicationController
  def login
  end

  def check_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to user
    else
      redirect_to login_path, flash: { 
        errors: [ "invalid email or password" ]
      }
    end
  end
end
