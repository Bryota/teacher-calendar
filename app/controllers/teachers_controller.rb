class TeachersController < ApplicationController
  before_action :check_log_in_as_teacher, except:[:new, :create]
  before_action :current_teacher
  before_action :get_teacher, only:[:show, :edit, :update]
  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def show
    @plans = TeacherPlanSearchService.new.call(current_teacher)
    @today_plans = @plans.where('start_time < ?', Date.current.next_day)
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

  def edit
  end

  def update
    if @teacher && @teacher.authenticate(params[:teacher][:password])
      if @teacher.update(teacher_params)
        redirect_to @teacher
      else
        redirect_to edit_teacher_url, flash: {
          errors: ['invalid name']
        }
      end
    else
      redirect_to edit_teacher_url, flash: {
        errors: ['invalid password']
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

    def get_teacher
      @teacher = Teacher.find_by(id: params[:id])
    end
end
