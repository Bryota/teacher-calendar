class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to user_path @user.id
    else
      redirect_to new_password_reset_url, flash: {
        errors: ['invalid email']
      }
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      redirect_to edit_password_reset_url(email: @user.email), flash: {
        errors: @user.errors.full_messages
      }
    elsif @user.update(user_params)
      log_in @user
      redirect_to @user
    else
      redirect_to edit_password_reset_url(email: @user.email), flash: {
        errors: @user.errors.full_messages
      }
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def check_expiration
      if @user.password_reset_expired?
        redirect_to new_password_reset_url, flash: {
          errors: ['Password reset has expired.']
        }
      end
    end
end
