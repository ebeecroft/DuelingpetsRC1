require "application_system_test_case"

class SubplaylistsTest < ApplicationSystemTestCase
  setup do
    @subplaylist = subplaylists(:one)
  end

  test "visiting the index" do
    visit subplaylists_url
    assert_selector "h1", text: "Subplaylists"
  end

  test "creating a Subplaylist" do
    visit subplaylists_url
    click_on "New Subplaylist"

    check "Collab mode" if @subplaylist.collab_mode
    fill_in "Created on", with: @subplaylist.created_on
    fill_in "Description", with: @subplaylist.description
    check "Fave folder" if @subplaylist.fave_folder
    fill_in "Mainplaylist", with: @subplaylist.mainplaylist_id
    check "Privatesubplaylist" if @subplaylist.privatesubplaylist
    fill_in "Title", with: @subplaylist.title
    fill_in "Updated on", with: @subplaylist.updated_on
    fill_in "User", with: @subplaylist.user_id
    click_on "Create Subplaylist"

    assert_text "Subplaylist was successfully created"
    click_on "Back"
  end

  test "updating a Subplaylist" do
    visit subplaylists_url
    click_on "Edit", match: :first

    check "Collab mode" if @subplaylist.collab_mode
    fill_in "Created on", with: @subplaylist.created_on
    fill_in "Description", with: @subplaylist.description
    check "Fave folder" if @subplaylist.fave_folder
    fill_in "Mainplaylist", with: @subplaylist.mainplaylist_id
    check "Privatesubplaylist" if @subplaylist.privatesubplaylist
    fill_in "Title", with: @subplaylist.title
    fill_in "Updated on", with: @subplaylist.updated_on
    fill_in "User", with: @subplaylist.user_id
    click_on "Update Subplaylist"

    assert_text "Subplaylist was successfully updated"
    click_on "Back"
  end

  test "destroying a Subplaylist" do
    visit subplaylists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subplaylist was successfully destroyed"
  end
end
