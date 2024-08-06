require "test_helper"

class TagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tag_index_url
    assert_response :success
  end

  test "should get edit" do
    get tag_edit_url
    assert_response :success
  end

  test "should get update" do
    get tag_update_url
    assert_response :success
  end
end
