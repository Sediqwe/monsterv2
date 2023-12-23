require "test_helper"

class SupportlistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supportlist = supportlists(:one)
  end

  test "should get index" do
    get supportlists_url
    assert_response :success
  end

  test "should get new" do
    get new_supportlist_url
    assert_response :success
  end

  test "should create supportlist" do
    assert_difference("Supportlist.count") do
      post supportlists_url, params: { supportlist: { active: @supportlist.active, iconbootstrap: @supportlist.iconbootstrap, link: @supportlist.link, name: @supportlist.name, user_id: @supportlist.user_id } }
    end

    assert_redirected_to supportlist_url(Supportlist.last)
  end

  test "should show supportlist" do
    get supportlist_url(@supportlist)
    assert_response :success
  end

  test "should get edit" do
    get edit_supportlist_url(@supportlist)
    assert_response :success
  end

  test "should update supportlist" do
    patch supportlist_url(@supportlist), params: { supportlist: { active: @supportlist.active, iconbootstrap: @supportlist.iconbootstrap, link: @supportlist.link, name: @supportlist.name, user_id: @supportlist.user_id } }
    assert_redirected_to supportlist_url(@supportlist)
  end

  test "should destroy supportlist" do
    assert_difference("Supportlist.count", -1) do
      delete supportlist_url(@supportlist)
    end

    assert_redirected_to supportlists_url
  end
end
