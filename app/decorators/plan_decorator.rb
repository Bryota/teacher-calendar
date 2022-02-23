class PlanDecorator < ApplicationDecorator
  delegate_all

  def start_time
    object.start_time.strftime("%Y/%m/%d")
  end

  def place
    if (object.place == 'zoom')
        return 'Zoom'
    end
    if (object.place == 'school')
        return '学校'
    end
    if (object.place == 'others')
        return 'その他'
    end
  end

  def title
    if (object.title == 'bachelor_thesis')
      return '卒論の相談'
    end
    if (object.title == 'course')
        return '履修の相談'
    end
    if (object.title == 'class')
        return '授業の相談'
    end
    if (object.title == 'others')
        return 'その他'
    end
  end
end
