require "test_helper"

class IndulasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get indulas_index_url
    assert_response :success
  end
end
