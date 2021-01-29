require "application_system_test_case"

class DifficultiesTest < ApplicationSystemTestCase
  setup do
    @difficulty = difficulties(:one)
  end

  test "visiting the index" do
    visit difficulties_url
    assert_selector "h1", text: "Difficulties"
  end

  test "creating a Difficulty" do
    visit difficulties_url
    click_on "New Difficulty"

    fill_in "Created on", with: @difficulty.created_on
    fill_in "Emeralddebt", with: @difficulty.emeralddebt
    fill_in "Emeraldloan", with: @difficulty.emeraldloan
    fill_in "Name", with: @difficulty.name
    fill_in "Pointdebt", with: @difficulty.pointdebt
    fill_in "Pointloan", with: @difficulty.pointloan
    click_on "Create Difficulty"

    assert_text "Difficulty was successfully created"
    click_on "Back"
  end

  test "updating a Difficulty" do
    visit difficulties_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @difficulty.created_on
    fill_in "Emeralddebt", with: @difficulty.emeralddebt
    fill_in "Emeraldloan", with: @difficulty.emeraldloan
    fill_in "Name", with: @difficulty.name
    fill_in "Pointdebt", with: @difficulty.pointdebt
    fill_in "Pointloan", with: @difficulty.pointloan
    click_on "Update Difficulty"

    assert_text "Difficulty was successfully updated"
    click_on "Back"
  end

  test "destroying a Difficulty" do
    visit difficulties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Difficulty was successfully destroyed"
  end
end
