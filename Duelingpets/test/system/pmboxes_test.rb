require "application_system_test_case"

class PmboxesTest < ApplicationSystemTestCase
  setup do
    @pmbox = pmboxes(:one)
  end

  test "visiting the index" do
    visit pmboxes_url
    assert_selector "h1", text: "Pmboxes"
  end

  test "creating a Pmbox" do
    visit pmboxes_url
    click_on "New Pmbox"

    check "Box open" if @pmbox.box_open
    fill_in "User", with: @pmbox.user_id
    click_on "Create Pmbox"

    assert_text "Pmbox was successfully created"
    click_on "Back"
  end

  test "updating a Pmbox" do
    visit pmboxes_url
    click_on "Edit", match: :first

    check "Box open" if @pmbox.box_open
    fill_in "User", with: @pmbox.user_id
    click_on "Update Pmbox"

    assert_text "Pmbox was successfully updated"
    click_on "Back"
  end

  test "destroying a Pmbox" do
    visit pmboxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pmbox was successfully destroyed"
  end
end
