module AuthHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !current_user.nil?
    end

    def log_in_as_teacher(teacher)
        session[:teacher_id] = teacher.id
    end

    def current_teacher
        if session[:teacher_id]
            @current_teacher ||= Teacher.find_by(id: session[:teacher_id])
        end
    end

    def logged_in_as_teacher?
        !current_teacher.nil?
    end
end
