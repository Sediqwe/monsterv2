require "application_system_test_case"

class HoppsTest < ApplicationSystemTestCase
  setup do
    @hopp = hopps(:one)
  end

  test "visiting the index" do
    visit hopps_url
    assert_selector "h1", text: "Hopps"
  end

  test "should create hopp" do
    visit hopps_url
    click_on "New hopp"

    fill_in "Gen", with: @hopp.gen
    fill_in "Link", with: @hopp.link
    fill_in "Open", with: @hopp.open
    click_on "Create Hopp"

    assert_text "Hopp was successfully created"
    click_on "Back"
  end

  test "should update Hopp" do
    visit hopp_url(@hopp)
    click_on "Edit this hopp", match: :first

    fill_in "Gen", with: @hopp.gen
    fill_in "Link", with: @hopp.link
    fill_in "Open", with: @hopp.open
    click_on "Update Hopp"

    assert_text "Hopp was successfully updated"
    click_on "Back"
  end

  test "should destroy Hopp" do
    visit hopp_url(@hopp)
    click_on "Destroy this hopp", match: :first

    assert_text "Hopp was successfully destroyed"
  end
end
