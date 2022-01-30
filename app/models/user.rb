class User < ApplicationRecord
    attr_accessor :reset_token
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    has_secure_password
    validates :password, presence: true

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
end
