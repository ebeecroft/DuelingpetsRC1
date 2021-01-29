require "application_system_test_case"

class FieldcostsTest < ApplicationSystemTestCase
  setup do
    @fieldcost = fieldcosts(:one)
  end

  test "visiting the index" do
    visit fieldcosts_url
    assert_selector "h1", text: "Fieldcosts"
  end

  test "creating a Fieldcost" do
    visit fieldcosts_url
    click_on "New Fieldcost"

    fill_in "Amount", with: @fieldcost.amount
    fill_in "Baseinc", with: @fieldcost.baseinc_id
    fill_in "Created on", with: @fieldcost.created_on
    fill_in "Dragonhoard", with: @fieldcost.dragonhoard_id
    fill_in "Econtype", with: @fieldcost.econtype
    fill_in "Name", with: @fieldcost.name
    fill_in "Updated on", with: @fieldcost.updated_on
    click_on "Create Fieldcost"

    assert_text "Fieldcost was successfully created"
    click_on "Back"
  end

  test "updating a Fieldcost" do
    visit fieldcosts_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @fieldcost.amount
    fill_in "Baseinc", with: @fieldcost.baseinc_id
    fill_in "Created on", with: @fieldcost.created_on
    fill_in "Dragonhoard", with: @fieldcost.dragonhoard_id
    fill_in "Econtype", with: @fieldcost.econtype
    fill_in "Name", with: @fieldcost.name
    fill_in "Updated on", with: @fieldcost.updated_on
    click_on "Update Fieldcost"

    assert_text "Fieldcost was successfully updated"
    click_on "Back"
  end

  test "destroying a Fieldcost" do
    visit fieldcosts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fieldcost was successfully destroyed"
  end
end
