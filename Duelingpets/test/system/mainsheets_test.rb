require "application_system_test_case"

class MainsheetsTest < ApplicationSystemTestCase
  setup do
    @mainsheet = mainsheets(:one)
  end

  test "visiting the index" do
    visit mainsheets_url
    assert_selector "h1", text: "Mainsheets"
  end

  test "creating a Mainsheet" do
    visit mainsheets_url
    click_on "New Mainsheet"

    fill_in "Created on", with: @mainsheet.created_on
    fill_in "Description", with: @mainsheet.description
    fill_in "Jukebox", with: @mainsheet.jukebox_id
    fill_in "Title", with: @mainsheet.title
    fill_in "Updated on", with: @mainsheet.updated_on
    fill_in "User", with: @mainsheet.user_id
    click_on "Create Mainsheet"

    assert_text "Mainsheet was successfully created"
    click_on "Back"
  end

  test "updating a Mainsheet" do
    visit mainsheets_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @mainsheet.created_on
    fill_in "Description", with: @mainsheet.description
    fill_in "Jukebox", with: @mainsheet.jukebox_id
    fill_in "Title", with: @mainsheet.title
    fill_in "Updated on", with: @mainsheet.updated_on
    fill_in "User", with: @mainsheet.user_id
    click_on "Update Mainsheet"

    assert_text "Mainsheet was successfully updated"
    click_on "Back"
  end

  test "destroying a Mainsheet" do
    visit mainsheets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mainsheet was successfully destroyed"
  end
end
