class UserPlanSearchService < ApplicationService
    attr_reader :user

    def call(user)
        @user = user
        search_plan @user
    end

    private

    def search_plan(user)
        user.plans.where('start_time > ?', Date.today)
    end
end