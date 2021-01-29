require "application_system_test_case"

class ItemtypesTest < ApplicationSystemTestCase
  setup do
    @itemtype = itemtypes(:one)
  end

  test "visiting the index" do
    visit itemtypes_url
    assert_selector "h1", text: "Itemtypes"
  end

  test "creating a Itemtype" do
    visit itemtypes_url
    click_on "New Itemtype"

    fill_in "Basecost", with: @itemtype.basecost
    fill_in "Created on", with: @itemtype.created_on
    check "Demoitem" if @itemtype.demoitem
    fill_in "Dreyterriumcost", with: @itemtype.dreyterriumcost
    fill_in "Name", with: @itemtype.name
    click_on "Create Itemtype"

    assert_text "Itemtype was successfully created"
    click_on "Back"
  end

  test "updating a Itemtype" do
    visit itemtypes_url
    click_on "Edit", match: :first

    fill_in "Basecost", with: @itemtype.basecost
    fill_in "Created on", with: @itemtype.created_on
    check "Demoitem" if @itemtype.demoitem
    fill_in "Dreyterriumcost", with: @itemtype.dreyterriumcost
    fill_in "Name", with: @itemtype.name
    click_on "Update Itemtype"

    assert_text "Itemtype was successfully updated"
    click_on "Back"
  end

  test "destroying a Itemtype" do
    visit itemtypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Itemtype was successfully destroyed"
  end
end
