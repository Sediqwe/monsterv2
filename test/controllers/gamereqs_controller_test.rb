require "test_helper"

class GamereqsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gamereq = gamereqs(:one)
  end

  test "should get index" do
    get gamereqs_url
    assert_response :success
  end

  test "should get new" do
    get new_gamereq_url
    assert_response :success
  end

  test "should create gamereq" do
    assert_difference("Gamereq.count") do
      post gamereqs_url, params: { gamereq: { desc: @gamereq.desc, game_id: @gamereq.game_id, gamelink: @gamereq.gamelink, gamename: @gamereq.gamename, oke: @gamereq.oke, user_id: @gamereq.user_id, username: @gamereq.username } }
    end

    assert_redirected_to gamereq_url(Gamereq.last)
  end

  test "should show gamereq" do
    get gamereq_url(@gamereq)
    assert_response :success
  end

  test "should get edit" do
    get edit_gamereq_url(@gamereq)
    assert_response :success
  end

  test "should update gamereq" do
    patch gamereq_url(@gamereq), params: { gamereq: { desc: @gamereq.desc, game_id: @gamereq.game_id, gamelink: @gamereq.gamelink, gamename: @gamereq.gamename, oke: @gamereq.oke, user_id: @gamereq.user_id, username: @gamereq.username } }
    assert_redirected_to gamereq_url(@gamereq)
  end

  test "should destroy gamereq" do
    assert_difference("Gamereq.count", -1) do
      delete gamereq_url(@gamereq)
    end

    assert_redirected_to gamereqs_url
  end
end
