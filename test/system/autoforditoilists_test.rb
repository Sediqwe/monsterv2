require "application_system_test_case"

class AutoforditoilistsTest < ApplicationSystemTestCase
  setup do
    @autoforditoilist = autoforditoilists(:one)
  end

  test "visiting the index" do
    visit autoforditoilists_url
    assert_selector "h1", text: "Autoforditoilists"
  end

  test "should create autoforditoilist" do
    visit autoforditoilists_url
    click_on "New autoforditoilist"

    check "Active" if @autoforditoilist.active
    fill_in "Game", with: @autoforditoilist.game_id
    fill_in "Tipus", with: @autoforditoilist.tipus
    fill_in "Upload", with: @autoforditoilist.upload_id
    click_on "Create Autoforditoilist"

    assert_text "Autoforditoilist was successfully created"
    click_on "Back"
  end

  test "should update Autoforditoilist" do
    visit autoforditoilist_url(@autoforditoilist)
    click_on "Edit this autoforditoilist", match: :first

    check "Active" if @autoforditoilist.active
    fill_in "Game", with: @autoforditoilist.game_id
    fill_in "Tipus", with: @autoforditoilist.tipus
    fill_in "Upload", with: @autoforditoilist.upload_id
    click_on "Update Autoforditoilist"

    assert_text "Autoforditoilist was successfully updated"
    click_on "Back"
  end

  test "should destroy Autoforditoilist" do
    visit autoforditoilist_url(@autoforditoilist)
    click_on "Destroy this autoforditoilist", match: :first

    assert_text "Autoforditoilist was successfully destroyed"
  end
end
