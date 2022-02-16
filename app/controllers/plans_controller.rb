class PlansController < ApplicationController
  before_action :check_log_in_as_user, except:[:index, :all, :show, :cancel]
  before_action :check_log_in_user_or_teacher, only:[:index, :all, :show,]
  before_action :current_user, only:[:new, :create, :edit, :update, :delete]
  before_action :current_teacher
  before_action :get_plan, only:[:show, :edit, :update, :cancel]

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
  end

  def new
    @plan = Plan.new
    @date = params[:date]
    @teacher_id = params[:teacher_id]
    if !Plan.find_by(start_time: DateTime.parse(@date), teacher_id: @teacher_id.to_i).nil?
      redirect_to plans_path(teacher_id: @teacher_id)
    end
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
  end

  def update
    if @plan.update(plan_params)
      redirect_to plans_path(teacher_id: params[:plan][:teacher_id])
    else
      redirect_to edit_plan_path(@plan), flash: {
        errors: @plan.errors.full_messages
      }
    end
  end

  def destroy
    plan = Plan.find(params[:id])
    plan.destroy
    redirect_to plans_path(teacher_id: plan.teacher_id)
  end

  def cancel
    authorize @plan
    @plan.update(canceled: true)
    redirect_to plans_path(teacher_id: @plan.teacher_id)
  end

  private
    def plan_params
      params.require(:plan).permit(:name, :title, :place, :content, :start_time, :teacher_id, :user_id, :canceled)
    end

    def get_plan
      @plan = Plan.find_by(id: params[:id])
    end
end
