require "application_system_test_case"

class DreyoresTest < ApplicationSystemTestCase
  setup do
    @dreyore = dreyores(:one)
  end

  test "visiting the index" do
    visit dreyores_url
    assert_selector "h1", text: "Dreyores"
  end

  test "creating a Dreyore" do
    visit dreyores_url
    click_on "New Dreyore"

    fill_in "Cap", with: @dreyore.cap
    fill_in "Change", with: @dreyore.change
    fill_in "Created on", with: @dreyore.created_on
    fill_in "Cur", with: @dreyore.cur
    fill_in "Dragonhoard", with: @dreyore.dragonhoard_id
    fill_in "Extracted", with: @dreyore.extracted
    fill_in "Name", with: @dreyore.name
    fill_in "Price", with: @dreyore.price
    fill_in "Updated on", with: @dreyore.updated_on
    click_on "Create Dreyore"

    assert_text "Dreyore was successfully created"
    click_on "Back"
  end

  test "updating a Dreyore" do
    visit dreyores_url
    click_on "Edit", match: :first

    fill_in "Cap", with: @dreyore.cap
    fill_in "Change", with: @dreyore.change
    fill_in "Created on", with: @dreyore.created_on
    fill_in "Cur", with: @dreyore.cur
    fill_in "Dragonhoard", with: @dreyore.dragonhoard_id
    fill_in "Extracted", with: @dreyore.extracted
    fill_in "Name", with: @dreyore.name
    fill_in "Price", with: @dreyore.price
    fill_in "Updated on", with: @dreyore.updated_on
    click_on "Update Dreyore"

    assert_text "Dreyore was successfully updated"
    click_on "Back"
  end

  test "destroying a Dreyore" do
    visit dreyores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dreyore was successfully destroyed"
  end
end
