class PlanDecorator < ApplicationDecorator
  delegate_all

  def start_time
    start_time.strftime("%Y/%m/%d")
  end
end
