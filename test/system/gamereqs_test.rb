require "application_system_test_case"

class GamereqsTest < ApplicationSystemTestCase
  setup do
    @gamereq = gamereqs(:one)
  end

  test "visiting the index" do
    visit gamereqs_url
    assert_selector "h1", text: "Gamereqs"
  end

  test "should create gamereq" do
    visit gamereqs_url
    click_on "New gamereq"

    fill_in "Desc", with: @gamereq.desc
    fill_in "Game", with: @gamereq.game_id
    fill_in "Gamelink", with: @gamereq.gamelink
    fill_in "Gamename", with: @gamereq.gamename
    check "Oke" if @gamereq.oke
    fill_in "User", with: @gamereq.user_id
    fill_in "Username", with: @gamereq.username
    click_on "Create Gamereq"

    assert_text "Gamereq was successfully created"
    click_on "Back"
  end

  test "should update Gamereq" do
    visit gamereq_url(@gamereq)
    click_on "Edit this gamereq", match: :first

    fill_in "Desc", with: @gamereq.desc
    fill_in "Game", with: @gamereq.game_id
    fill_in "Gamelink", with: @gamereq.gamelink
    fill_in "Gamename", with: @gamereq.gamename
    check "Oke" if @gamereq.oke
    fill_in "User", with: @gamereq.user_id
    fill_in "Username", with: @gamereq.username
    click_on "Update Gamereq"

    assert_text "Gamereq was successfully updated"
    click_on "Back"
  end

  test "should destroy Gamereq" do
    visit gamereq_url(@gamereq)
    click_on "Destroy this gamereq", match: :first

    assert_text "Gamereq was successfully destroyed"
  end
end
