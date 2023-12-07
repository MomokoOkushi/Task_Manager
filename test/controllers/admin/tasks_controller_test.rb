require "test_helper"

class Admin::TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_tasks_show_url
    assert_response :success
  end
end
