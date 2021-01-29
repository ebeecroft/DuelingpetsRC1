require "application_system_test_case"

class GalleriesTest < ApplicationSystemTestCase
  setup do
    @gallery = galleries(:one)
  end

  test "visiting the index" do
    visit galleries_url
    assert_selector "h1", text: "Galleries"
  end

  test "creating a Gallery" do
    visit galleries_url
    click_on "New Gallery"

    fill_in "Bookgroup", with: @gallery.bookgroup_id
    fill_in "Created on", with: @gallery.created_on
    fill_in "Description", with: @gallery.description
    fill_in "Mp3", with: @gallery.mp3
    check "Music on" if @gallery.music_on
    fill_in "Name", with: @gallery.name
    fill_in "Ogg", with: @gallery.ogg
    check "Privategallery" if @gallery.privategallery
    fill_in "Updated on", with: @gallery.updated_on
    fill_in "User", with: @gallery.user_id
    click_on "Create Gallery"

    assert_text "Gallery was successfully created"
    click_on "Back"
  end

  test "updating a Gallery" do
    visit galleries_url
    click_on "Edit", match: :first

    fill_in "Bookgroup", with: @gallery.bookgroup_id
    fill_in "Created on", with: @gallery.created_on
    fill_in "Description", with: @gallery.description
    fill_in "Mp3", with: @gallery.mp3
    check "Music on" if @gallery.music_on
    fill_in "Name", with: @gallery.name
    fill_in "Ogg", with: @gallery.ogg
    check "Privategallery" if @gallery.privategallery
    fill_in "Updated on", with: @gallery.updated_on
    fill_in "User", with: @gallery.user_id
    click_on "Update Gallery"

    assert_text "Gallery was successfully updated"
    click_on "Back"
  end

  test "destroying a Gallery" do
    visit galleries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Gallery was successfully destroyed"
  end
end
