class ApplicationController < ActionController::Base
    include AuthHelper
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :render_403
    helper_method :gender

    def check_log_in_as_user
        if !logged_in?
            redirect_to login_path
        end
    end

    def check_log_in_as_teacher
        if !logged_in_as_teacher?
            redirect_to teachers_login_path
        end
    end

    def check_log_in_user_or_teacher
        if logged_in? || logged_in_as_teacher?
        else
            redirect_to login_path
        end
    end

    def gender(gender_num)
        if gender_num === 0
            '男'
        elsif gender_num == 1
            '女'
        elsif gender_num == 2
            'その他'
        end
    end

    def render_403
        render template: '403', status: 403, layout:false
    end
end
