require "test_helper"

class SupportersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supporter = supporters(:one)
  end

  test "should get index" do
    get supporters_url
    assert_response :success
  end

  test "should get new" do
    get new_supporter_url
    assert_response :success
  end

  test "should create supporter" do
    assert_difference("Supporter.count") do
      post supporters_url, params: { supporter: { datum: @supporter.datum, euro: @supporter.euro, name: @supporter.name } }
    end

    assert_redirected_to supporter_url(Supporter.last)
  end

  test "should show supporter" do
    get supporter_url(@supporter)
    assert_response :success
  end

  test "should get edit" do
    get edit_supporter_url(@supporter)
    assert_response :success
  end

  test "should update supporter" do
    patch supporter_url(@supporter), params: { supporter: { datum: @supporter.datum, euro: @supporter.euro, name: @supporter.name } }
    assert_redirected_to supporter_url(@supporter)
  end

  test "should destroy supporter" do
    assert_difference("Supporter.count", -1) do
      delete supporter_url(@supporter)
    end

    assert_redirected_to supporters_url
  end
end
