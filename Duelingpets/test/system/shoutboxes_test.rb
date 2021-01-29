require "application_system_test_case"

class ShoutboxesTest < ApplicationSystemTestCase
  setup do
    @shoutbox = shoutboxes(:one)
  end

  test "visiting the index" do
    visit shoutboxes_url
    assert_selector "h1", text: "Shoutboxes"
  end

  test "creating a Shoutbox" do
    visit shoutboxes_url
    click_on "New Shoutbox"

    check "Box open" if @shoutbox.box_open
    fill_in "Capacity", with: @shoutbox.capacity
    fill_in "User", with: @shoutbox.user_id
    click_on "Create Shoutbox"

    assert_text "Shoutbox was successfully created"
    click_on "Back"
  end

  test "updating a Shoutbox" do
    visit shoutboxes_url
    click_on "Edit", match: :first

    check "Box open" if @shoutbox.box_open
    fill_in "Capacity", with: @shoutbox.capacity
    fill_in "User", with: @shoutbox.user_id
    click_on "Update Shoutbox"

    assert_text "Shoutbox was successfully updated"
    click_on "Back"
  end

  test "destroying a Shoutbox" do
    visit shoutboxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shoutbox was successfully destroyed"
  end
end
