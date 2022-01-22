require "test_helper"

class UsersCrudTest < ActionDispatch::IntegrationTest
  test "add user test" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "testuser", email: "test@example.com", password: "testtest", password_confirmation: "testtest"} }
    end
    assert_redirected_to users_path
  end

  test "add invalid params" do
    assert_not User.create(name: '', email: 'test@example.com', password: "testtest", password_confirmation: "testtest").valid?
    assert_not User.create(name: 'testuser', email: '', password: "testtest", password_confirmation: "testtest").valid?
    assert_not User.create(name: 'testuser', email: 'test@example.com', password: "", password_confirmation: "testtest").valid?
    assert_not User.create(name: 'testuser', email: 'test@example.com', password: "testtest", password_confirmation: "").valid?
    assert_not User.create(name: 'testuser', email: 'test@example.com', password: "testtest", password_confirmation: "test").valid?
  end
end
