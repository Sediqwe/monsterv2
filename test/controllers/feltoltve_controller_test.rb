require "test_helper"

class FeltoltveControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get feltoltve_index_url
    assert_response :success
  end
end
