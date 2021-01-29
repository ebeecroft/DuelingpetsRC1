require "application_system_test_case"

class PouchtypesTest < ApplicationSystemTestCase
  setup do
    @pouchtype = pouchtypes(:one)
  end

  test "visiting the index" do
    visit pouchtypes_url
    assert_selector "h1", text: "Pouchtypes"
  end

  test "creating a Pouchtype" do
    visit pouchtypes_url
    click_on "New Pouchtype"

    fill_in "Created on", with: @pouchtype.created_on
    fill_in "Name", with: @pouchtype.name
    click_on "Create Pouchtype"

    assert_text "Pouchtype was successfully created"
    click_on "Back"
  end

  test "updating a Pouchtype" do
    visit pouchtypes_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @pouchtype.created_on
    fill_in "Name", with: @pouchtype.name
    click_on "Update Pouchtype"

    assert_text "Pouchtype was successfully updated"
    click_on "Back"
  end

  test "destroying a Pouchtype" do
    visit pouchtypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pouchtype was successfully destroyed"
  end
end
