require "application_system_test_case"

class BlogtypesTest < ApplicationSystemTestCase
  setup do
    @blogtype = blogtypes(:one)
  end

  test "visiting the index" do
    visit blogtypes_url
    assert_selector "h1", text: "Blogtypes"
  end

  test "creating a Blogtype" do
    visit blogtypes_url
    click_on "New Blogtype"

    fill_in "Created on", with: @blogtype.created_on
    fill_in "Name", with: @blogtype.name
    click_on "Create Blogtype"

    assert_text "Blogtype was successfully created"
    click_on "Back"
  end

  test "updating a Blogtype" do
    visit blogtypes_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @blogtype.created_on
    fill_in "Name", with: @blogtype.name
    click_on "Update Blogtype"

    assert_text "Blogtype was successfully updated"
    click_on "Back"
  end

  test "destroying a Blogtype" do
    visit blogtypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blogtype was successfully destroyed"
  end
end
