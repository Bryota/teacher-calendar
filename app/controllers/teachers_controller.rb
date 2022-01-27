class TeachersController < ApplicationController
  before_action :check_log_in_as_teacher, except:[:new, :create]
  before_action :current_teacher
  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def show
    @teacher = Teacher.find_by(id: params[:id])
    @plans = Plan.where(teacher_id: params[:id])
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      log_in_as_teacher @teacher
      redirect_to plans_path(teacher_id: @teacher.id)
    else
      redirect_to new_teacher_path, flash: {
        errors: @teacher.errors.full_messages
      }
    end
  end

  def destroy
    session[:teacher_id] = nil
    @current_teacher = nil
    redirect_to teachers_login_path
  end

  private
    def teacher_params
      params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
    end
end
