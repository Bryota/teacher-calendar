class TeacherPasswordResetsController < ApplicationController
  before_action :get_teacher, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def create
    @teacher = Teacher.find_by(email: params[:password_reset][:email])
    if @teacher
      @teacher.create_reset_digest
      @teacher.send_password_reset_email
      redirect_to teacher_path @teacher.id
    else
      redirect_to new_teacher_password_reset_url, flash: {
        errors: ['invalid email']
      }
    end
  end

  def edit
  end

  def update
    if params[:teacher][:password].empty?
      @teacher.errors.add(:password, :blank)
      redirect_to edit_teacher_password_reset_url(email: @teacher.email), flash: {
        errors: @teacher.errors.full_messages
      }
    elsif @teacher.update(teacher_params)
      log_in_as_teacher @teacher
      redirect_to @teacher
    else
      redirect_to edit_teacher_password_reset_url(email: @teacher.email), flash: {
        errors: @teacher.errors.full_messages
      }
    end
  end

  private
    def teacher_params
      params.require(:teacher).permit(:password, :password_confirmation)
    end

    def get_teacher
      @teacher = Teacher.find_by(email: params[:email])
    end

    def check_expiration
      if @teacher.password_reset_expired?
        redirect_to new_teacher_password_reset_url, flash: {
          errors: ['Password reset has expired.']
        }
      end
    end
end
