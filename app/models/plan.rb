class Plan < ApplicationRecord
    belongs_to :teacher
    validates :name, presence: true
    validates :title, presence: true
    validates :place, presence: true
    validates :content, presence: true
    validates :start_time, presence: true, uniqueness: { scope: [:teacher_id] }
    validates :teacher_id, presence: true
end
