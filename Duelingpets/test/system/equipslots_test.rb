require "application_system_test_case"

class EquipslotsTest < ApplicationSystemTestCase
  setup do
    @equipslot = equipslots(:one)
  end

  test "visiting the index" do
    visit equipslots_url
    assert_selector "h1", text: "Equipslots"
  end

  test "creating a Equipslot" do
    visit equipslots_url
    click_on "New Equipslot"

    check "Activeslot" if @equipslot.activeslot
    fill_in "Curdur1", with: @equipslot.curdur1
    fill_in "Curdur2", with: @equipslot.curdur2
    fill_in "Curdur3", with: @equipslot.curdur3
    fill_in "Curdur4", with: @equipslot.curdur4
    fill_in "Curdur5", with: @equipslot.curdur5
    fill_in "Curdur6", with: @equipslot.curdur6
    fill_in "Curdur7", with: @equipslot.curdur7
    fill_in "Curdur8", with: @equipslot.curdur8
    fill_in "Equip", with: @equipslot.equip_id
    fill_in "Item1", with: @equipslot.item1_id
    fill_in "Item2", with: @equipslot.item2_id
    fill_in "Item3", with: @equipslot.item3_id
    fill_in "Item4", with: @equipslot.item4_id
    fill_in "Item5", with: @equipslot.item5_id
    fill_in "Item6", with: @equipslot.item6_id
    fill_in "Item7", with: @equipslot.item7_id
    fill_in "Item8", with: @equipslot.item8_id
    fill_in "Name", with: @equipslot.name
    fill_in "Startdur1", with: @equipslot.startdur1
    fill_in "Startdur2", with: @equipslot.startdur2
    fill_in "Startdur3", with: @equipslot.startdur3
    fill_in "Startdur4", with: @equipslot.startdur4
    fill_in "Startdur5", with: @equipslot.startdur5
    fill_in "Startdur6", with: @equipslot.startdur6
    fill_in "Startdur7", with: @equipslot.startdur7
    fill_in "Startdur8", with: @equipslot.startdur8
    click_on "Create Equipslot"

    assert_text "Equipslot was successfully created"
    click_on "Back"
  end

  test "updating a Equipslot" do
    visit equipslots_url
    click_on "Edit", match: :first

    check "Activeslot" if @equipslot.activeslot
    fill_in "Curdur1", with: @equipslot.curdur1
    fill_in "Curdur2", with: @equipslot.curdur2
    fill_in "Curdur3", with: @equipslot.curdur3
    fill_in "Curdur4", with: @equipslot.curdur4
    fill_in "Curdur5", with: @equipslot.curdur5
    fill_in "Curdur6", with: @equipslot.curdur6
    fill_in "Curdur7", with: @equipslot.curdur7
    fill_in "Curdur8", with: @equipslot.curdur8
    fill_in "Equip", with: @equipslot.equip_id
    fill_in "Item1", with: @equipslot.item1_id
    fill_in "Item2", with: @equipslot.item2_id
    fill_in "Item3", with: @equipslot.item3_id
    fill_in "Item4", with: @equipslot.item4_id
    fill_in "Item5", with: @equipslot.item5_id
    fill_in "Item6", with: @equipslot.item6_id
    fill_in "Item7", with: @equipslot.item7_id
    fill_in "Item8", with: @equipslot.item8_id
    fill_in "Name", with: @equipslot.name
    fill_in "Startdur1", with: @equipslot.startdur1
    fill_in "Startdur2", with: @equipslot.startdur2
    fill_in "Startdur3", with: @equipslot.startdur3
    fill_in "Startdur4", with: @equipslot.startdur4
    fill_in "Startdur5", with: @equipslot.startdur5
    fill_in "Startdur6", with: @equipslot.startdur6
    fill_in "Startdur7", with: @equipslot.startdur7
    fill_in "Startdur8", with: @equipslot.startdur8
    click_on "Update Equipslot"

    assert_text "Equipslot was successfully updated"
    click_on "Back"
  end

  test "destroying a Equipslot" do
    visit equipslots_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Equipslot was successfully destroyed"
  end
end
