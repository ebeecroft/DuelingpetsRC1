require "application_system_test_case"

class PmrepliesTest < ApplicationSystemTestCase
  setup do
    @pmreply = pmreplies(:one)
  end

  test "visiting the index" do
    visit pmreplies_url
    assert_selector "h1", text: "Pmreplies"
  end

  test "creating a Pmreply" do
    visit pmreplies_url
    click_on "New Pmreply"

    fill_in "Created on", with: @pmreply.created_on
    fill_in "Image", with: @pmreply.image
    fill_in "Message", with: @pmreply.message
    fill_in "Mp3", with: @pmreply.mp3
    fill_in "Mp4", with: @pmreply.mp4
    fill_in "Ogg", with: @pmreply.ogg
    fill_in "Ogv", with: @pmreply.ogv
    fill_in "Pm", with: @pmreply.pm_id
    fill_in "Updated on", with: @pmreply.updated_on
    fill_in "User", with: @pmreply.user_id
    click_on "Create Pmreply"

    assert_text "Pmreply was successfully created"
    click_on "Back"
  end

  test "updating a Pmreply" do
    visit pmreplies_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @pmreply.created_on
    fill_in "Image", with: @pmreply.image
    fill_in "Message", with: @pmreply.message
    fill_in "Mp3", with: @pmreply.mp3
    fill_in "Mp4", with: @pmreply.mp4
    fill_in "Ogg", with: @pmreply.ogg
    fill_in "Ogv", with: @pmreply.ogv
    fill_in "Pm", with: @pmreply.pm_id
    fill_in "Updated on", with: @pmreply.updated_on
    fill_in "User", with: @pmreply.user_id
    click_on "Update Pmreply"

    assert_text "Pmreply was successfully updated"
    click_on "Back"
  end

  test "destroying a Pmreply" do
    visit pmreplies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pmreply was successfully destroyed"
  end
end
