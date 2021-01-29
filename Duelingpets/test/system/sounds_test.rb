require "application_system_test_case"

class SoundsTest < ApplicationSystemTestCase
  setup do
    @sound = sounds(:one)
  end

  test "visiting the index" do
    visit sounds_url
    assert_selector "h1", text: "Sounds"
  end

  test "creating a Sound" do
    visit sounds_url
    click_on "New Sound"

    fill_in "Bookgroup", with: @sound.bookgroup_id
    fill_in "Created on", with: @sound.created_on
    fill_in "Description", with: @sound.description
    fill_in "Mp3", with: @sound.mp3
    fill_in "Ogg", with: @sound.ogg
    check "Pointsreceived" if @sound.pointsreceived
    check "Reviewed" if @sound.reviewed
    fill_in "Reviewed on", with: @sound.reviewed_on
    fill_in "Subsheet", with: @sound.subsheet_id
    fill_in "Title", with: @sound.title
    fill_in "Updated on", with: @sound.updated_on
    fill_in "User", with: @sound.user_id
    click_on "Create Sound"

    assert_text "Sound was successfully created"
    click_on "Back"
  end

  test "updating a Sound" do
    visit sounds_url
    click_on "Edit", match: :first

    fill_in "Bookgroup", with: @sound.bookgroup_id
    fill_in "Created on", with: @sound.created_on
    fill_in "Description", with: @sound.description
    fill_in "Mp3", with: @sound.mp3
    fill_in "Ogg", with: @sound.ogg
    check "Pointsreceived" if @sound.pointsreceived
    check "Reviewed" if @sound.reviewed
    fill_in "Reviewed on", with: @sound.reviewed_on
    fill_in "Subsheet", with: @sound.subsheet_id
    fill_in "Title", with: @sound.title
    fill_in "Updated on", with: @sound.updated_on
    fill_in "User", with: @sound.user_id
    click_on "Update Sound"

    assert_text "Sound was successfully updated"
    click_on "Back"
  end

  test "destroying a Sound" do
    visit sounds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sound was successfully destroyed"
  end
end
