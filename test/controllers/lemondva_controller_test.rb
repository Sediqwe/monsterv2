require "test_helper"

class LemondvaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lemondva_index_url
    assert_response :success
  end
end
