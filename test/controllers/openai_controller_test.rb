require "test_helper"

class OpenaiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get openai_index_url
    assert_response :success
  end
end
