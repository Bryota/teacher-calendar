class UsersController < ApplicationController
  before_action :check_log_in_as_user, except:[:new, :create]
  before_action :current_user, except:[:new]
  before_action :get_user, only:[:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @plans = UserDecorator.decorate_collection(UserPlanSearchService.new.call(current_user))
    @today_plans = @plans.where('start_time < ?', Date.current.next_day)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      redirect_to new_user_url, flash: {
        errors: @user.errors.full_messages
      }
    end
  end

  def edit
  end

  def update
    if @user && @user.authenticate(params[:user][:password])
      if @user.update(user_params) 
        redirect_to @user
      else
        redirect_to edit_user_url, flash: {
          errors: ['invalid name']
        }
      end
    else
      redirect_to edit_user_url, flash: {
        errors: ['invalid password']
      }
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to login_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(id: params[:id])
    end
end
