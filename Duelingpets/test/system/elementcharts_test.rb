require "application_system_test_case"

class ElementchartsTest < ApplicationSystemTestCase
  setup do
    @elementchart = elementcharts(:one)
  end

  test "visiting the index" do
    visit elementcharts_url
    assert_selector "h1", text: "Elementcharts"
  end

  test "creating a Elementchart" do
    visit elementcharts_url
    click_on "New Elementchart"

    fill_in "Created on", with: @elementchart.created_on
    fill_in "Element", with: @elementchart.element_id
    fill_in "Estrength", with: @elementchart.estrength_id
    fill_in "Eweak", with: @elementchart.eweak_id
    fill_in "Sstrength", with: @elementchart.sstrength_id
    fill_in "Sweak", with: @elementchart.sweak_id
    fill_in "Updated on", with: @elementchart.updated_on
    click_on "Create Elementchart"

    assert_text "Elementchart was successfully created"
    click_on "Back"
  end

  test "updating a Elementchart" do
    visit elementcharts_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @elementchart.created_on
    fill_in "Element", with: @elementchart.element_id
    fill_in "Estrength", with: @elementchart.estrength_id
    fill_in "Eweak", with: @elementchart.eweak_id
    fill_in "Sstrength", with: @elementchart.sstrength_id
    fill_in "Sweak", with: @elementchart.sweak_id
    fill_in "Updated on", with: @elementchart.updated_on
    click_on "Update Elementchart"

    assert_text "Elementchart was successfully updated"
    click_on "Back"
  end

  test "destroying a Elementchart" do
    visit elementcharts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Elementchart was successfully destroyed"
  end
end
