require "application_system_test_case"

class SupportlistsTest < ApplicationSystemTestCase
  setup do
    @supportlist = supportlists(:one)
  end

  test "visiting the index" do
    visit supportlists_url
    assert_selector "h1", text: "Supportlists"
  end

  test "should create supportlist" do
    visit supportlists_url
    click_on "New supportlist"

    check "Active" if @supportlist.active
    fill_in "Iconbootstrap", with: @supportlist.iconbootstrap
    fill_in "Link", with: @supportlist.link
    fill_in "Name", with: @supportlist.name
    fill_in "User", with: @supportlist.user_id
    click_on "Create Supportlist"

    assert_text "Supportlist was successfully created"
    click_on "Back"
  end

  test "should update Supportlist" do
    visit supportlist_url(@supportlist)
    click_on "Edit this supportlist", match: :first

    check "Active" if @supportlist.active
    fill_in "Iconbootstrap", with: @supportlist.iconbootstrap
    fill_in "Link", with: @supportlist.link
    fill_in "Name", with: @supportlist.name
    fill_in "User", with: @supportlist.user_id
    click_on "Update Supportlist"

    assert_text "Supportlist was successfully updated"
    click_on "Back"
  end

  test "should destroy Supportlist" do
    visit supportlist_url(@supportlist)
    click_on "Destroy this supportlist", match: :first

    assert_text "Supportlist was successfully destroyed"
  end
end
