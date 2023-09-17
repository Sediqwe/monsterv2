require "test_helper"

class HoppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hopp = hopps(:one)
  end

  test "should get index" do
    get hopps_url
    assert_response :success
  end

  test "should get new" do
    get new_hopp_url
    assert_response :success
  end

  test "should create hopp" do
    assert_difference("Hopp.count") do
      post hopps_url, params: { hopp: { gen: @hopp.gen, link: @hopp.link, open: @hopp.open } }
    end

    assert_redirected_to hopp_url(Hopp.last)
  end

  test "should show hopp" do
    get hopp_url(@hopp)
    assert_response :success
  end

  test "should get edit" do
    get edit_hopp_url(@hopp)
    assert_response :success
  end

  test "should update hopp" do
    patch hopp_url(@hopp), params: { hopp: { gen: @hopp.gen, link: @hopp.link, open: @hopp.open } }
    assert_redirected_to hopp_url(@hopp)
  end

  test "should destroy hopp" do
    assert_difference("Hopp.count", -1) do
      delete hopp_url(@hopp)
    end

    assert_redirected_to hopps_url
  end
end
