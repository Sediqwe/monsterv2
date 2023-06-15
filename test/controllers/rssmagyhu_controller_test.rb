require "test_helper"

class RssmagyhuControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rssmagyhu_index_url
    assert_response :success
  end
end
