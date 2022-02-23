class UserDecorator < ApplicationDecorator
  delegate_all

  def start_time
    object.start_time.strftime("%Y/%m/%d")
  end

end
