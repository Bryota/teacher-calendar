class Teacher < ApplicationRecord
    has_one :plan
    validates :name, presence: true
end
