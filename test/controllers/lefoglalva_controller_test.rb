require "test_helper"

class LefoglalvaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lefoglalva_index_url
    assert_response :success
  end
end
