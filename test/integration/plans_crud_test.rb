require "test_helper"

class PlansCrudTest < ActionDispatch::IntegrationTest
  def setup
    @plan = plans(:one)
  end

  test "plan create test" do
    get new_plan_path(date: Date.new)
    assert_difference 'Plan.count', 1 do
      post plans_path, params: { plan: { name: 'mac', title: 'bachelor_thesis', place: 'zoom', content: 'sample text', start_time: Date.new } }
    end
    assert_redirected_to plans_path
  end

  test "plan create invalid params" do
    assert_not Plan.create(name: '', title: 'bachelor_thesis', place: 'zoom', content: 'sample text', start_time: Date.new).valid?
    assert_not Plan.create(name: 'mac', title: '', place: 'zoom', content: 'sample text', start_time: Date.new).valid?
    assert_not Plan.create(name: 'mac', title: 'bachelor_thesis', place: '', content: 'sample text', start_time: Date.new).valid?
    assert_not Plan.create(name: 'mac', title: 'bachelor_thesis', place: 'zoom', content: '', start_time: Date.new).valid?
    assert_not Plan.create(name: 'mac', title: 'bachelor_thesis', place: 'zoom', content: '', start_time: '').valid?
  end

  test "plan update test" do
    get edit_plan_path(@plan)
    patch plan_path(@plan), params: { plan: { name: 'mac', title: 'bachelor_thesis', place: 'zoom', content: 'sample text', start_time: Date.new } }
    assert_redirected_to plans_path
  end

  test "plan destroy test" do
    assert_difference "Plan.count", -1 do
      delete plan_path(@plan)
    end
    assert_redirected_to plans_path
  end

end
