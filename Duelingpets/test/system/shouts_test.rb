require "application_system_test_case"

class ShoutsTest < ApplicationSystemTestCase
  setup do
    @shout = shouts(:one)
  end

  test "visiting the index" do
    visit shouts_url
    assert_selector "h1", text: "Shouts"
  end

  test "creating a Shout" do
    visit shouts_url
    click_on "New Shout"

    fill_in "Bookgroup", with: @shout.bookgroup_id
    fill_in "Created on", with: @shout.created_on
    fill_in "Message", with: @shout.message
    check "Reviewed" if @shout.reviewed
    fill_in "Reviewed on", with: @shout.reviewed_on
    fill_in "Shoutbox", with: @shout.shoutbox_id
    fill_in "Updated on", with: @shout.updated_on
    fill_in "User", with: @shout.user_id
    click_on "Create Shout"

    assert_text "Shout was successfully created"
    click_on "Back"
  end

  test "updating a Shout" do
    visit shouts_url
    click_on "Edit", match: :first

    fill_in "Bookgroup", with: @shout.bookgroup_id
    fill_in "Created on", with: @shout.created_on
    fill_in "Message", with: @shout.message
    check "Reviewed" if @shout.reviewed
    fill_in "Reviewed on", with: @shout.reviewed_on
    fill_in "Shoutbox", with: @shout.shoutbox_id
    fill_in "Updated on", with: @shout.updated_on
    fill_in "User", with: @shout.user_id
    click_on "Update Shout"

    assert_text "Shout was successfully updated"
    click_on "Back"
  end

  test "destroying a Shout" do
    visit shouts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shout was successfully destroyed"
  end
end
