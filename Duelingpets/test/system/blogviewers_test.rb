require "application_system_test_case"

class BlogviewersTest < ApplicationSystemTestCase
  setup do
    @blogviewer = blogviewers(:one)
  end

  test "visiting the index" do
    visit blogviewers_url
    assert_selector "h1", text: "Blogviewers"
  end

  test "creating a Blogviewer" do
    visit blogviewers_url
    click_on "New Blogviewer"

    fill_in "Created on", with: @blogviewer.created_on
    fill_in "Name", with: @blogviewer.name
    click_on "Create Blogviewer"

    assert_text "Blogviewer was successfully created"
    click_on "Back"
  end

  test "updating a Blogviewer" do
    visit blogviewers_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @blogviewer.created_on
    fill_in "Name", with: @blogviewer.name
    click_on "Update Blogviewer"

    assert_text "Blogviewer was successfully updated"
    click_on "Back"
  end

  test "destroying a Blogviewer" do
    visit blogviewers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blogviewer was successfully destroyed"
  end
end
