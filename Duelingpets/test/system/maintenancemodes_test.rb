require "application_system_test_case"

class MaintenancemodesTest < ApplicationSystemTestCase
  setup do
    @maintenancemode = maintenancemodes(:one)
  end

  test "visiting the index" do
    visit maintenancemodes_url
    assert_selector "h1", text: "Maintenancemodes"
  end

  test "creating a Maintenancemode" do
    visit maintenancemodes_url
    click_on "New Maintenancemode"

    fill_in "Created on", with: @maintenancemode.created_on
    check "Maintenance on" if @maintenancemode.maintenance_on
    fill_in "Name", with: @maintenancemode.name
    click_on "Create Maintenancemode"

    assert_text "Maintenancemode was successfully created"
    click_on "Back"
  end

  test "updating a Maintenancemode" do
    visit maintenancemodes_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @maintenancemode.created_on
    check "Maintenance on" if @maintenancemode.maintenance_on
    fill_in "Name", with: @maintenancemode.name
    click_on "Update Maintenancemode"

    assert_text "Maintenancemode was successfully updated"
    click_on "Back"
  end

  test "destroying a Maintenancemode" do
    visit maintenancemodes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Maintenancemode was successfully destroyed"
  end
end
