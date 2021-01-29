require "application_system_test_case"

class JukeboxesTest < ApplicationSystemTestCase
  setup do
    @jukebox = jukeboxes(:one)
  end

  test "visiting the index" do
    visit jukeboxes_url
    assert_selector "h1", text: "Jukeboxes"
  end

  test "creating a Jukebox" do
    visit jukeboxes_url
    click_on "New Jukebox"

    fill_in "Bookgroup", with: @jukebox.bookgroup_id
    fill_in "Created on", with: @jukebox.created_on
    fill_in "Description", with: @jukebox.description
    fill_in "Mp3", with: @jukebox.mp3
    check "Music on" if @jukebox.music_on
    fill_in "Name", with: @jukebox.name
    fill_in "Ogg", with: @jukebox.ogg
    check "Privatejukebox" if @jukebox.privatejukebox
    fill_in "Updated on", with: @jukebox.updated_on
    fill_in "User", with: @jukebox.user_id
    click_on "Create Jukebox"

    assert_text "Jukebox was successfully created"
    click_on "Back"
  end

  test "updating a Jukebox" do
    visit jukeboxes_url
    click_on "Edit", match: :first

    fill_in "Bookgroup", with: @jukebox.bookgroup_id
    fill_in "Created on", with: @jukebox.created_on
    fill_in "Description", with: @jukebox.description
    fill_in "Mp3", with: @jukebox.mp3
    check "Music on" if @jukebox.music_on
    fill_in "Name", with: @jukebox.name
    fill_in "Ogg", with: @jukebox.ogg
    check "Privatejukebox" if @jukebox.privatejukebox
    fill_in "Updated on", with: @jukebox.updated_on
    fill_in "User", with: @jukebox.user_id
    click_on "Update Jukebox"

    assert_text "Jukebox was successfully updated"
    click_on "Back"
  end

  test "destroying a Jukebox" do
    visit jukeboxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Jukebox was successfully destroyed"
  end
end
