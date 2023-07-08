require "test_helper"

class GeneratorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get generator_index_url
    assert_response :success
  end

  test "should get new" do
    get generator_new_url
    assert_response :success
  end
end
