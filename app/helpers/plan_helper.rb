module PlanHelper
    def titleToString(title)
        if (title == 'bachelor_thesis')
            return '卒論の相談'
        end
        if (title == 'course')
            return '履修の相談'
        end
        if (title == 'class')
            return '授業の相談'
        end
        if (title == 'others')
            return 'その他'
        end
    end

    def placeToString(title)
        if (title == 'zoom')
            return 'Zoom'
        end
        if (title == 'school')
            return '学校'
        end
        if (title == 'others')
            return 'その他'
        end
    end
end
