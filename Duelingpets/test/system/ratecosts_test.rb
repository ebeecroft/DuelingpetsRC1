require "application_system_test_case"

class RatecostsTest < ApplicationSystemTestCase
  setup do
    @ratecost = ratecosts(:one)
  end

  test "visiting the index" do
    visit ratecosts_url
    assert_selector "h1", text: "Ratecosts"
  end

  test "creating a Ratecost" do
    visit ratecosts_url
    click_on "New Ratecost"

    fill_in "Amount", with: @ratecost.amount
    fill_in "Baserate", with: @ratecost.baserate_id
    fill_in "Created on", with: @ratecost.created_on
    fill_in "Dragonhoard", with: @ratecost.dragonhoard_id
    fill_in "Econtype", with: @ratecost.econtype
    fill_in "Name", with: @ratecost.name
    fill_in "Updated on", with: @ratecost.updated_on
    click_on "Create Ratecost"

    assert_text "Ratecost was successfully created"
    click_on "Back"
  end

  test "updating a Ratecost" do
    visit ratecosts_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @ratecost.amount
    fill_in "Baserate", with: @ratecost.baserate_id
    fill_in "Created on", with: @ratecost.created_on
    fill_in "Dragonhoard", with: @ratecost.dragonhoard_id
    fill_in "Econtype", with: @ratecost.econtype
    fill_in "Name", with: @ratecost.name
    fill_in "Updated on", with: @ratecost.updated_on
    click_on "Update Ratecost"

    assert_text "Ratecost was successfully updated"
    click_on "Back"
  end

  test "destroying a Ratecost" do
    visit ratecosts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ratecost was successfully destroyed"
  end
end
