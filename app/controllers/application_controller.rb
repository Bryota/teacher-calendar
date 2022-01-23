class ApplicationController < ActionController::Base
    include AuthHelper

    def check_log_in_as_user
        if !logged_in?
            redirect_to login_path
        end
    end

    def check_log_in_user_or_teacher
        if logged_in? || logged_in_as_teacher?
        else
            redirect_to login_path
        end
    end
end
