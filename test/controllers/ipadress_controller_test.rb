require "test_helper"

class IpadressControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ipadress_index_url
    assert_response :success
  end
end
