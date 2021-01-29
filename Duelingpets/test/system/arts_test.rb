require "application_system_test_case"

class ArtsTest < ApplicationSystemTestCase
  setup do
    @art = arts(:one)
  end

  test "visiting the index" do
    visit arts_url
    assert_selector "h1", text: "Arts"
  end

  test "creating a Art" do
    visit arts_url
    click_on "New Art"

    fill_in "Bookgroup", with: @art.bookgroup_id
    fill_in "Created on", with: @art.created_on
    fill_in "Description", with: @art.description
    fill_in "Image", with: @art.image
    fill_in "Mp3", with: @art.mp3
    fill_in "Ogg", with: @art.ogg
    check "Pointsreceived" if @art.pointsreceived
    check "Reviewed" if @art.reviewed
    fill_in "Reviewed on", with: @art.reviewed_on
    fill_in "Subfolder", with: @art.subfolder_id
    fill_in "Title", with: @art.title
    fill_in "Updated on", with: @art.updated_on
    fill_in "User", with: @art.user_id
    click_on "Create Art"

    assert_text "Art was successfully created"
    click_on "Back"
  end

  test "updating a Art" do
    visit arts_url
    click_on "Edit", match: :first

    fill_in "Bookgroup", with: @art.bookgroup_id
    fill_in "Created on", with: @art.created_on
    fill_in "Description", with: @art.description
    fill_in "Image", with: @art.image
    fill_in "Mp3", with: @art.mp3
    fill_in "Ogg", with: @art.ogg
    check "Pointsreceived" if @art.pointsreceived
    check "Reviewed" if @art.reviewed
    fill_in "Reviewed on", with: @art.reviewed_on
    fill_in "Subfolder", with: @art.subfolder_id
    fill_in "Title", with: @art.title
    fill_in "Updated on", with: @art.updated_on
    fill_in "User", with: @art.user_id
    click_on "Update Art"

    assert_text "Art was successfully updated"
    click_on "Back"
  end

  test "destroying a Art" do
    visit arts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Art was successfully destroyed"
  end
end
