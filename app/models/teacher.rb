class Teacher < ApplicationRecord
    has_one :plan
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    has_secure_password
    validates :password, presence: true
end
