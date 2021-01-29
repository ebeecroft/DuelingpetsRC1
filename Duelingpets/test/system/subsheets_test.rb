require "application_system_test_case"

class SubsheetsTest < ApplicationSystemTestCase
  setup do
    @subsheet = subsheets(:one)
  end

  test "visiting the index" do
    visit subsheets_url
    assert_selector "h1", text: "Subsheets"
  end

  test "creating a Subsheet" do
    visit subsheets_url
    click_on "New Subsheet"

    check "Collab mode" if @subsheet.collab_mode
    fill_in "Created on", with: @subsheet.created_on
    fill_in "Description", with: @subsheet.description
    check "Fave folder" if @subsheet.fave_folder
    fill_in "Mainsheet", with: @subsheet.mainsheet_id
    check "Privatesubsheet" if @subsheet.privatesubsheet
    fill_in "Title", with: @subsheet.title
    fill_in "Updated on", with: @subsheet.updated_on
    fill_in "User", with: @subsheet.user_id
    click_on "Create Subsheet"

    assert_text "Subsheet was successfully created"
    click_on "Back"
  end

  test "updating a Subsheet" do
    visit subsheets_url
    click_on "Edit", match: :first

    check "Collab mode" if @subsheet.collab_mode
    fill_in "Created on", with: @subsheet.created_on
    fill_in "Description", with: @subsheet.description
    check "Fave folder" if @subsheet.fave_folder
    fill_in "Mainsheet", with: @subsheet.mainsheet_id
    check "Privatesubsheet" if @subsheet.privatesubsheet
    fill_in "Title", with: @subsheet.title
    fill_in "Updated on", with: @subsheet.updated_on
    fill_in "User", with: @subsheet.user_id
    click_on "Update Subsheet"

    assert_text "Subsheet was successfully updated"
    click_on "Back"
  end

  test "destroying a Subsheet" do
    visit subsheets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subsheet was successfully destroyed"
  end
end
