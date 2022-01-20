require "test_helper"

class PlansControllerTest < ActionDispatch::IntegrationTest
  # test "should get index" do
  #   get plan_index_url
  #   assert_response :success
  # end

  # test "should get show" do
  #   get plan_show_url
  #   assert_response :success
  # end

  test "should get new" do
    get new_plan_path(date: Date.new)
    assert_response :success
  end

  # test "should get edit" do
  #   get plan_edit_url
  #   assert_response :success
  # end
end
