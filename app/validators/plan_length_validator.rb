class PlanLengthValidator < ActiveModel::Validator
    def validate(plan)
        plan.errors.add(:base, '相談詳細は３文字以上書いてください。') if plan.content.size <= 3
    end
end