class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end

  def show
    @plan = Plan.find_by(id: params[:id])
  end

  def new
    @plan = Plan.new
    @date = params[:date]
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plans_path
    else
      redirect_to new_plan_path
    end
  end

  def edit
    @plan = Plan.find_by(id: params[:id])
  end

  def update
    @plan = Plan.find_by(id: params[:id])
    if @plan.update(plan_params)
      redirect_to plans_path
    else
      redirect_to :back
    end
  end

  def destroy
    Plan.find(params[:id]).destroy
    redirect_to plans_path
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :title, :place, :content, :start_time)
  end
end
