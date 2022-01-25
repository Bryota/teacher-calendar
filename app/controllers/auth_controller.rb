class AuthController < ApplicationController
  def login
  end

  def login_teacher
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

  def check_teacher
    teacher = Teacher.find_by(email: params[:email])
    if teacher
      log_in_as_teacher teacher
      redirect_to teachers_path
    else
      redirect_to teachers_login_path, flash: { 
        errors: [ "invalid email" ]
      }
    end
  end
end
