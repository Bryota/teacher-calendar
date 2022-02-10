class TeacherPlanSearchService < ApplicationService
    attr_reader :teacher

    def call(teacher)
        @teacher = teacher
        search_plan @teacher
    end

    private

    def search_plan(teacher)
        teacher.plans.where('start_time > ?', Date.today)
    end
end