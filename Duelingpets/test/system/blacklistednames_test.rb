require "application_system_test_case"

class BlacklistednamesTest < ApplicationSystemTestCase
  setup do
    @blacklistedname = blacklistednames(:one)
  end

  test "visiting the index" do
    visit blacklistednames_url
    assert_selector "h1", text: "Blacklistednames"
  end

  test "creating a Blacklistedname" do
    visit blacklistednames_url
    click_on "New Blacklistedname"

    fill_in "Created on", with: @blacklistedname.created_on
    fill_in "Name", with: @blacklistedname.name
    click_on "Create Blacklistedname"

    assert_text "Blacklistedname was successfully created"
    click_on "Back"
  end

  test "updating a Blacklistedname" do
    visit blacklistednames_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @blacklistedname.created_on
    fill_in "Name", with: @blacklistedname.name
    click_on "Update Blacklistedname"

    assert_text "Blacklistedname was successfully updated"
    click_on "Back"
  end

  test "destroying a Blacklistedname" do
    visit blacklistednames_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blacklistedname was successfully destroyed"
  end
end
