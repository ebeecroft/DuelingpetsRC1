require "application_system_test_case"

class ArtpagesTest < ApplicationSystemTestCase
  setup do
    @artpage = artpages(:one)
  end

  test "visiting the index" do
    visit artpages_url
    assert_selector "h1", text: "Artpages"
  end

  test "creating a Artpage" do
    visit artpages_url
    click_on "New Artpage"

    fill_in "Art", with: @artpage.art
    fill_in "Created on", with: @artpage.created_on
    fill_in "Message", with: @artpage.message
    fill_in "Name", with: @artpage.name
    click_on "Create Artpage"

    assert_text "Artpage was successfully created"
    click_on "Back"
  end

  test "updating a Artpage" do
    visit artpages_url
    click_on "Edit", match: :first

    fill_in "Art", with: @artpage.art
    fill_in "Created on", with: @artpage.created_on
    fill_in "Message", with: @artpage.message
    fill_in "Name", with: @artpage.name
    click_on "Update Artpage"

    assert_text "Artpage was successfully updated"
    click_on "Back"
  end

  test "destroying a Artpage" do
    visit artpages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Artpage was successfully destroyed"
  end
end
