# frozen_string_literal: true

class PlanPolicy < ApplicationPolicy
  attr_reader :user, :plan

  def initialize(user, plan)
    @user = user
    @plan = plan
  end
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  def cancel?
    !plan.canceled
  end
end
