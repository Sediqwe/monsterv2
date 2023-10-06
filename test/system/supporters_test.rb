require "application_system_test_case"

class SupportersTest < ApplicationSystemTestCase
  setup do
    @supporter = supporters(:one)
  end

  test "visiting the index" do
    visit supporters_url
    assert_selector "h1", text: "Supporters"
  end

  test "should create supporter" do
    visit supporters_url
    click_on "New supporter"

    fill_in "Datum", with: @supporter.datum
    fill_in "Euro", with: @supporter.euro
    fill_in "Name", with: @supporter.name
    click_on "Create Supporter"

    assert_text "Supporter was successfully created"
    click_on "Back"
  end

  test "should update Supporter" do
    visit supporter_url(@supporter)
    click_on "Edit this supporter", match: :first

    fill_in "Datum", with: @supporter.datum
    fill_in "Euro", with: @supporter.euro
    fill_in "Name", with: @supporter.name
    click_on "Update Supporter"

    assert_text "Supporter was successfully updated"
    click_on "Back"
  end

  test "should destroy Supporter" do
    visit supporter_url(@supporter)
    click_on "Destroy this supporter", match: :first

    assert_text "Supporter was successfully destroyed"
  end
end
