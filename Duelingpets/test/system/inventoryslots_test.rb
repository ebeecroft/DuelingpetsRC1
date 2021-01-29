require "application_system_test_case"

class InventoryslotsTest < ApplicationSystemTestCase
  setup do
    @inventoryslot = inventoryslots(:one)
  end

  test "visiting the index" do
    visit inventoryslots_url
    assert_selector "h1", text: "Inventoryslots"
  end

  test "creating a Inventoryslot" do
    visit inventoryslots_url
    click_on "New Inventoryslot"

    fill_in "Inventory", with: @inventoryslot.inventory_id
    fill_in "Mainitem1", with: @inventoryslot.mainitem1_id
    fill_in "Mainitem2", with: @inventoryslot.mainitem2_id
    fill_in "Mainitem3", with: @inventoryslot.mainitem3_id
    fill_in "Mainitem4", with: @inventoryslot.mainitem4_id
    fill_in "Mcurdur1", with: @inventoryslot.mcurdur1
    fill_in "Mcurdur2", with: @inventoryslot.mcurdur2
    fill_in "Mcurdur3", with: @inventoryslot.mcurdur3
    fill_in "Mcurdur4", with: @inventoryslot.mcurdur4
    fill_in "Mitemcost1", with: @inventoryslot.mitemcost1
    fill_in "Mitemcost2", with: @inventoryslot.mitemcost2
    fill_in "Mitemcost3", with: @inventoryslot.mitemcost3
    fill_in "Mitemcost4", with: @inventoryslot.mitemcost4
    fill_in "Mmaxdur1", with: @inventoryslot.mmaxdur1
    fill_in "Mmaxdur2", with: @inventoryslot.mmaxdur2
    fill_in "Mmaxdur3", with: @inventoryslot.mmaxdur3
    fill_in "Mmaxdur4", with: @inventoryslot.mmaxdur4
    fill_in "Mmindur1", with: @inventoryslot.mmindur1
    fill_in "Mmindur2", with: @inventoryslot.mmindur2
    fill_in "Mmindur3", with: @inventoryslot.mmindur3
    fill_in "Mmindur4", with: @inventoryslot.mmindur4
    fill_in "Mqty1", with: @inventoryslot.mqty1
    fill_in "Mqty2", with: @inventoryslot.mqty2
    fill_in "Mqty3", with: @inventoryslot.mqty3
    fill_in "Mqty4", with: @inventoryslot.mqty4
    fill_in "Scurdur1a", with: @inventoryslot.scurdur1a
    fill_in "Scurdur2a", with: @inventoryslot.scurdur2a
    fill_in "Scurdur3a", with: @inventoryslot.scurdur3a
    fill_in "Scurdur4a", with: @inventoryslot.scurdur4a
    fill_in "Sitemcost1a", with: @inventoryslot.sitemcost1a
    fill_in "Sitemcost2a", with: @inventoryslot.sitemcost2a
    fill_in "Sitemcost3a", with: @inventoryslot.sitemcost3a
    fill_in "Sitemcost4a", with: @inventoryslot.sitemcost4a
    fill_in "Smaxdur1a", with: @inventoryslot.smaxdur1a
    fill_in "Smaxdur2a", with: @inventoryslot.smaxdur2a
    fill_in "Smaxdur3a", with: @inventoryslot.smaxdur3a
    fill_in "Smaxdur4a", with: @inventoryslot.smaxdur4a
    fill_in "Smindur1a", with: @inventoryslot.smindur1a
    fill_in "Smindur2a", with: @inventoryslot.smindur2a
    fill_in "Smindur3a", with: @inventoryslot.smindur3a
    fill_in "Smindur4a", with: @inventoryslot.smindur4a
    fill_in "Sqty1a", with: @inventoryslot.sqty1a
    fill_in "Sqty2a", with: @inventoryslot.sqty2a
    fill_in "Sqty3a", with: @inventoryslot.sqty3a
    fill_in "Sqty4a", with: @inventoryslot.sqty4a
    fill_in "Subitem1a", with: @inventoryslot.subitem1a_id
    fill_in "Subitem2a", with: @inventoryslot.subitem2a_id
    fill_in "Subitem3a", with: @inventoryslot.subitem3a_id
    fill_in "Subitem4a", with: @inventoryslot.subitem4a_id
    click_on "Create Inventoryslot"

    assert_text "Inventoryslot was successfully created"
    click_on "Back"
  end

  test "updating a Inventoryslot" do
    visit inventoryslots_url
    click_on "Edit", match: :first

    fill_in "Inventory", with: @inventoryslot.inventory_id
    fill_in "Mainitem1", with: @inventoryslot.mainitem1_id
    fill_in "Mainitem2", with: @inventoryslot.mainitem2_id
    fill_in "Mainitem3", with: @inventoryslot.mainitem3_id
    fill_in "Mainitem4", with: @inventoryslot.mainitem4_id
    fill_in "Mcurdur1", with: @inventoryslot.mcurdur1
    fill_in "Mcurdur2", with: @inventoryslot.mcurdur2
    fill_in "Mcurdur3", with: @inventoryslot.mcurdur3
    fill_in "Mcurdur4", with: @inventoryslot.mcurdur4
    fill_in "Mitemcost1", with: @inventoryslot.mitemcost1
    fill_in "Mitemcost2", with: @inventoryslot.mitemcost2
    fill_in "Mitemcost3", with: @inventoryslot.mitemcost3
    fill_in "Mitemcost4", with: @inventoryslot.mitemcost4
    fill_in "Mmaxdur1", with: @inventoryslot.mmaxdur1
    fill_in "Mmaxdur2", with: @inventoryslot.mmaxdur2
    fill_in "Mmaxdur3", with: @inventoryslot.mmaxdur3
    fill_in "Mmaxdur4", with: @inventoryslot.mmaxdur4
    fill_in "Mmindur1", with: @inventoryslot.mmindur1
    fill_in "Mmindur2", with: @inventoryslot.mmindur2
    fill_in "Mmindur3", with: @inventoryslot.mmindur3
    fill_in "Mmindur4", with: @inventoryslot.mmindur4
    fill_in "Mqty1", with: @inventoryslot.mqty1
    fill_in "Mqty2", with: @inventoryslot.mqty2
    fill_in "Mqty3", with: @inventoryslot.mqty3
    fill_in "Mqty4", with: @inventoryslot.mqty4
    fill_in "Scurdur1a", with: @inventoryslot.scurdur1a
    fill_in "Scurdur2a", with: @inventoryslot.scurdur2a
    fill_in "Scurdur3a", with: @inventoryslot.scurdur3a
    fill_in "Scurdur4a", with: @inventoryslot.scurdur4a
    fill_in "Sitemcost1a", with: @inventoryslot.sitemcost1a
    fill_in "Sitemcost2a", with: @inventoryslot.sitemcost2a
    fill_in "Sitemcost3a", with: @inventoryslot.sitemcost3a
    fill_in "Sitemcost4a", with: @inventoryslot.sitemcost4a
    fill_in "Smaxdur1a", with: @inventoryslot.smaxdur1a
    fill_in "Smaxdur2a", with: @inventoryslot.smaxdur2a
    fill_in "Smaxdur3a", with: @inventoryslot.smaxdur3a
    fill_in "Smaxdur4a", with: @inventoryslot.smaxdur4a
    fill_in "Smindur1a", with: @inventoryslot.smindur1a
    fill_in "Smindur2a", with: @inventoryslot.smindur2a
    fill_in "Smindur3a", with: @inventoryslot.smindur3a
    fill_in "Smindur4a", with: @inventoryslot.smindur4a
    fill_in "Sqty1a", with: @inventoryslot.sqty1a
    fill_in "Sqty2a", with: @inventoryslot.sqty2a
    fill_in "Sqty3a", with: @inventoryslot.sqty3a
    fill_in "Sqty4a", with: @inventoryslot.sqty4a
    fill_in "Subitem1a", with: @inventoryslot.subitem1a_id
    fill_in "Subitem2a", with: @inventoryslot.subitem2a_id
    fill_in "Subitem3a", with: @inventoryslot.subitem3a_id
    fill_in "Subitem4a", with: @inventoryslot.subitem4a_id
    click_on "Update Inventoryslot"

    assert_text "Inventoryslot was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventoryslot" do
    visit inventoryslots_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventoryslot was successfully destroyed"
  end
end
