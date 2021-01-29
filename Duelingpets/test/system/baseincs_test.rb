require "application_system_test_case"

class BaseincsTest < ApplicationSystemTestCase
  setup do
    @baseinc = baseincs(:one)
  end

  test "visiting the index" do
    visit baseincs_url
    assert_selector "h1", text: "Baseincs"
  end

  test "creating a Baseinc" do
    visit baseincs_url
    click_on "New Baseinc"

    fill_in "Amount", with: @baseinc.amount
    fill_in "Name", with: @baseinc.name
    click_on "Create Baseinc"

    assert_text "Baseinc was successfully created"
    click_on "Back"
  end

  test "updating a Baseinc" do
    visit baseincs_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @baseinc.amount
    fill_in "Name", with: @baseinc.name
    click_on "Update Baseinc"

    assert_text "Baseinc was successfully updated"
    click_on "Back"
  end

  test "destroying a Baseinc" do
    visit baseincs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Baseinc was successfully destroyed"
  end
end
