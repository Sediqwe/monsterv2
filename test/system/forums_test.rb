require "application_system_test_case"

class ForumsTest < ApplicationSystemTestCase
  setup do
    @forum = forums(:one)
  end

  test "visiting the index" do
    visit forums_url
    assert_selector "h1", text: "Forums"
  end

  test "should create forum" do
    visit forums_url
    click_on "New forum"

    check "Al" if @forum.al
    fill_in "Desc", with: @forum.desc
    fill_in "Fo forum", with: @forum.fo_forum
    check "Online" if @forum.online
    fill_in "Title", with: @forum.title
    fill_in "User", with: @forum.user_id
    click_on "Create Forum"

    assert_text "Forum was successfully created"
    click_on "Back"
  end

  test "should update Forum" do
    visit forum_url(@forum)
    click_on "Edit this forum", match: :first

    check "Al" if @forum.al
    fill_in "Desc", with: @forum.desc
    fill_in "Fo forum", with: @forum.fo_forum
    check "Online" if @forum.online
    fill_in "Title", with: @forum.title
    fill_in "User", with: @forum.user_id
    click_on "Update Forum"

    assert_text "Forum was successfully updated"
    click_on "Back"
  end

  test "should destroy Forum" do
    visit forum_url(@forum)
    click_on "Destroy this forum", match: :first

    assert_text "Forum was successfully destroyed"
  end
end
