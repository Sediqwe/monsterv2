require "test_helper"

class AutoforditoilistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @autoforditoilist = autoforditoilists(:one)
  end

  test "should get index" do
    get autoforditoilists_url
    assert_response :success
  end

  test "should get new" do
    get new_autoforditoilist_url
    assert_response :success
  end

  test "should create autoforditoilist" do
    assert_difference("Autoforditoilist.count") do
      post autoforditoilists_url, params: { autoforditoilist: { active: @autoforditoilist.active, game_id: @autoforditoilist.game_id, tipus: @autoforditoilist.tipus, upload_id: @autoforditoilist.upload_id } }
    end

    assert_redirected_to autoforditoilist_url(Autoforditoilist.last)
  end

  test "should show autoforditoilist" do
    get autoforditoilist_url(@autoforditoilist)
    assert_response :success
  end

  test "should get edit" do
    get edit_autoforditoilist_url(@autoforditoilist)
    assert_response :success
  end

  test "should update autoforditoilist" do
    patch autoforditoilist_url(@autoforditoilist), params: { autoforditoilist: { active: @autoforditoilist.active, game_id: @autoforditoilist.game_id, tipus: @autoforditoilist.tipus, upload_id: @autoforditoilist.upload_id } }
    assert_redirected_to autoforditoilist_url(@autoforditoilist)
  end

  test "should destroy autoforditoilist" do
    assert_difference("Autoforditoilist.count", -1) do
      delete autoforditoilist_url(@autoforditoilist)
    end

    assert_redirected_to autoforditoilists_url
  end
end
