require "test_helper"

class User::TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_tasks_new_url
    assert_response :success
  end

  test "should get show" do
    get user_tasks_show_url
    assert_response :success
  end
end
