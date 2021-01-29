require "application_system_test_case"

class BookgroupsTest < ApplicationSystemTestCase
  setup do
    @bookgroup = bookgroups(:one)
  end

  test "visiting the index" do
    visit bookgroups_url
    assert_selector "h1", text: "Bookgroups"
  end

  test "creating a Bookgroup" do
    visit bookgroups_url
    click_on "New Bookgroup"

    fill_in "Created on", with: @bookgroup.created_on
    fill_in "Name", with: @bookgroup.name
    click_on "Create Bookgroup"

    assert_text "Bookgroup was successfully created"
    click_on "Back"
  end

  test "updating a Bookgroup" do
    visit bookgroups_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @bookgroup.created_on
    fill_in "Name", with: @bookgroup.name
    click_on "Update Bookgroup"

    assert_text "Bookgroup was successfully updated"
    click_on "Back"
  end

  test "destroying a Bookgroup" do
    visit bookgroups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bookgroup was successfully destroyed"
  end
end
