require "test_helper"

class GamerssControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gamerss_index_url
    assert_response :success
  end
end
