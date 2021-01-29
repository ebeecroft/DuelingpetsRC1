require "application_system_test_case"

class WarehousesTest < ApplicationSystemTestCase
  setup do
    @warehouse = warehouses(:one)
  end

  test "visiting the index" do
    visit warehouses_url
    assert_selector "h1", text: "Warehouses"
  end

  test "creating a Warehouse" do
    visit warehouses_url
    click_on "New Warehouse"

    fill_in "Created on", with: @warehouse.created_on
    fill_in "Message", with: @warehouse.message
    fill_in "Mp3", with: @warehouse.mp3
    fill_in "Name", with: @warehouse.name
    fill_in "Ogg", with: @warehouse.ogg
    fill_in "Profit", with: @warehouse.profit
    check "Store open" if @warehouse.store_open
    fill_in "Treasury", with: @warehouse.treasury
    fill_in "Updated on", with: @warehouse.updated_on
    click_on "Create Warehouse"

    assert_text "Warehouse was successfully created"
    click_on "Back"
  end

  test "updating a Warehouse" do
    visit warehouses_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @warehouse.created_on
    fill_in "Message", with: @warehouse.message
    fill_in "Mp3", with: @warehouse.mp3
    fill_in "Name", with: @warehouse.name
    fill_in "Ogg", with: @warehouse.ogg
    fill_in "Profit", with: @warehouse.profit
    check "Store open" if @warehouse.store_open
    fill_in "Treasury", with: @warehouse.treasury
    fill_in "Updated on", with: @warehouse.updated_on
    click_on "Update Warehouse"

    assert_text "Warehouse was successfully updated"
    click_on "Back"
  end

  test "destroying a Warehouse" do
    visit warehouses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Warehouse was successfully destroyed"
  end
end
