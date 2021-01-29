require "application_system_test_case"

class GchaptersTest < ApplicationSystemTestCase
  setup do
    @gchapter = gchapters(:one)
  end

  test "visiting the index" do
    visit gchapters_url
    assert_selector "h1", text: "Gchapters"
  end

  test "creating a Gchapter" do
    visit gchapters_url
    click_on "New Gchapter"

    fill_in "Created on", with: @gchapter.created_on
    fill_in "Title", with: @gchapter.title
    click_on "Create Gchapter"

    assert_text "Gchapter was successfully created"
    click_on "Back"
  end

  test "updating a Gchapter" do
    visit gchapters_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @gchapter.created_on
    fill_in "Title", with: @gchapter.title
    click_on "Update Gchapter"

    assert_text "Gchapter was successfully updated"
    click_on "Back"
  end

  test "destroying a Gchapter" do
    visit gchapters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Gchapter was successfully destroyed"
  end
end
