require "application_system_test_case"

class MainplaylistsTest < ApplicationSystemTestCase
  setup do
    @mainplaylist = mainplaylists(:one)
  end

  test "visiting the index" do
    visit mainplaylists_url
    assert_selector "h1", text: "Mainplaylists"
  end

  test "creating a Mainplaylist" do
    visit mainplaylists_url
    click_on "New Mainplaylist"

    fill_in "Channel", with: @mainplaylist.channel_id
    fill_in "Created on", with: @mainplaylist.created_on
    fill_in "Description", with: @mainplaylist.description
    fill_in "Title", with: @mainplaylist.title
    fill_in "Updated on", with: @mainplaylist.updated_on
    fill_in "User", with: @mainplaylist.user_id
    click_on "Create Mainplaylist"

    assert_text "Mainplaylist was successfully created"
    click_on "Back"
  end

  test "updating a Mainplaylist" do
    visit mainplaylists_url
    click_on "Edit", match: :first

    fill_in "Channel", with: @mainplaylist.channel_id
    fill_in "Created on", with: @mainplaylist.created_on
    fill_in "Description", with: @mainplaylist.description
    fill_in "Title", with: @mainplaylist.title
    fill_in "Updated on", with: @mainplaylist.updated_on
    fill_in "User", with: @mainplaylist.user_id
    click_on "Update Mainplaylist"

    assert_text "Mainplaylist was successfully updated"
    click_on "Back"
  end

  test "destroying a Mainplaylist" do
    visit mainplaylists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mainplaylist was successfully destroyed"
  end
end
