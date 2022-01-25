class PlansController < ApplicationController
  before_action :check_log_in_as_user, except:[:index, :all]
  before_action :check_log_in_user_or_teacher, only:[:index, :all]
  before_action :current_user, only:[:new, :create]
  before_action :current_teacher
  def all
    @teachers = Teacher.all
  end

  def index
    if params[:teacher_id].nil?
      redirect_to teachers_path
    end
    if !@current_teacher.nil?
      if @current_teacher.id != params[:teacher_id].to_i
        redirect_to teachers_path
      end
    end
    @plans = Plan.where(teacher_id: params[:teacher_id])
    @teacher = Teacher.find(params[:teacher_id])
  end

  def show
    @plan = Plan.find_by(id: params[:id])
  end

  def new
    @plan = Plan.new
    @user = @current_user
    @date = params[:date]
    @teacher_id = params[:teacher_id]
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plans_path(teacher_id: params[:plan][:teacher_id])
    else
      redirect_to new_plan_path(date: params[:plan][:start_time]), flash: {
        errors: @plan.errors.full_messages
      }
    end
  end

  def edit
    @plan = Plan.find_by(id: params[:id])
    @user = @current_user
  end

  def update
    @plan = Plan.find_by(id: params[:id])
    if @plan.update(plan_params)
      redirect_to plans_path
    else
      redirect_to edit_plan_path(@plan), flash: {
        errors: @plan.errors.full_messages
      }
    end
  end

  def destroy
    Plan.find(params[:id]).destroy
    redirect_to plans_path
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :title, :place, :content, :start_time, :teacher_id)
  end
end
