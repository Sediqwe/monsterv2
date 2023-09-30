require "test_helper"

class KukiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kuki_index_url
    assert_response :success
  end

  test "should get new" do
    get kuki_new_url
    assert_response :success
  end

  test "should get create" do
    get kuki_create_url
    assert_response :success
  end
end
