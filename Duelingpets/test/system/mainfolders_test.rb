require "application_system_test_case"

class MainfoldersTest < ApplicationSystemTestCase
  setup do
    @mainfolder = mainfolders(:one)
  end

  test "visiting the index" do
    visit mainfolders_url
    assert_selector "h1", text: "Mainfolders"
  end

  test "creating a Mainfolder" do
    visit mainfolders_url
    click_on "New Mainfolder"

    fill_in "Created on", with: @mainfolder.created_on
    fill_in "Description", with: @mainfolder.description
    fill_in "Gallery", with: @mainfolder.gallery_id
    fill_in "Title", with: @mainfolder.title
    fill_in "Updated on", with: @mainfolder.updated_on
    fill_in "User", with: @mainfolder.user_id
    click_on "Create Mainfolder"

    assert_text "Mainfolder was successfully created"
    click_on "Back"
  end

  test "updating a Mainfolder" do
    visit mainfolders_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @mainfolder.created_on
    fill_in "Description", with: @mainfolder.description
    fill_in "Gallery", with: @mainfolder.gallery_id
    fill_in "Title", with: @mainfolder.title
    fill_in "Updated on", with: @mainfolder.updated_on
    fill_in "User", with: @mainfolder.user_id
    click_on "Update Mainfolder"

    assert_text "Mainfolder was successfully updated"
    click_on "Back"
  end

  test "destroying a Mainfolder" do
    visit mainfolders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mainfolder was successfully destroyed"
  end
end
