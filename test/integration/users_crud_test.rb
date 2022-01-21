require "test_helper"

class UsersCrudTest < ActionDispatch::IntegrationTest
  test "add user test" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "testuser", email: "test@example.com"} }
    end
    assert_redirected_to users_path
  end

  test "add invalid params" do
    assert_not User.create(name: '', email: 'test@example.com').valid?
    assert_not User.create(name: 'testuser', email: '').valid?
  end
end
