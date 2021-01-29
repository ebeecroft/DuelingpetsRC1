require "application_system_test_case"

class SubfoldersTest < ApplicationSystemTestCase
  setup do
    @subfolder = subfolders(:one)
  end

  test "visiting the index" do
    visit subfolders_url
    assert_selector "h1", text: "Subfolders"
  end

  test "creating a Subfolder" do
    visit subfolders_url
    click_on "New Subfolder"

    check "Collab mode" if @subfolder.collab_mode
    fill_in "Created on", with: @subfolder.created_on
    fill_in "Description", with: @subfolder.description
    check "Fave folder" if @subfolder.fave_folder
    fill_in "Mainfolder", with: @subfolder.mainfolder_id
    check "Privatesubfolder" if @subfolder.privatesubfolder
    fill_in "Title", with: @subfolder.title
    fill_in "Updated on", with: @subfolder.updated_on
    fill_in "User", with: @subfolder.user_id
    click_on "Create Subfolder"

    assert_text "Subfolder was successfully created"
    click_on "Back"
  end

  test "updating a Subfolder" do
    visit subfolders_url
    click_on "Edit", match: :first

    check "Collab mode" if @subfolder.collab_mode
    fill_in "Created on", with: @subfolder.created_on
    fill_in "Description", with: @subfolder.description
    check "Fave folder" if @subfolder.fave_folder
    fill_in "Mainfolder", with: @subfolder.mainfolder_id
    check "Privatesubfolder" if @subfolder.privatesubfolder
    fill_in "Title", with: @subfolder.title
    fill_in "Updated on", with: @subfolder.updated_on
    fill_in "User", with: @subfolder.user_id
    click_on "Update Subfolder"

    assert_text "Subfolder was successfully updated"
    click_on "Back"
  end

  test "destroying a Subfolder" do
    visit subfolders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subfolder was successfully destroyed"
  end
end
