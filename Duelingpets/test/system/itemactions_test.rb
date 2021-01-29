require "application_system_test_case"

class ItemactionsTest < ApplicationSystemTestCase
  setup do
    @itemaction = itemactions(:one)
  end

  test "visiting the index" do
    visit itemactions_url
    assert_selector "h1", text: "Itemactions"
  end

  test "creating a Itemaction" do
    visit itemactions_url
    click_on "New Itemaction"

    fill_in "Created on", with: @itemaction.created_on
    fill_in "Name", with: @itemaction.name
    click_on "Create Itemaction"

    assert_text "Itemaction was successfully created"
    click_on "Back"
  end

  test "updating a Itemaction" do
    visit itemactions_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @itemaction.created_on
    fill_in "Name", with: @itemaction.name
    click_on "Update Itemaction"

    assert_text "Itemaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Itemaction" do
    visit itemactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Itemaction was successfully destroyed"
  end
end
