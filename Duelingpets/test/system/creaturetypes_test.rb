require "application_system_test_case"

class CreaturetypesTest < ApplicationSystemTestCase
  setup do
    @creaturetype = creaturetypes(:one)
  end

  test "visiting the index" do
    visit creaturetypes_url
    assert_selector "h1", text: "Creaturetypes"
  end

  test "creating a Creaturetype" do
    visit creaturetypes_url
    click_on "New Creaturetype"

    fill_in "Basecost", with: @creaturetype.basecost
    fill_in "Created on", with: @creaturetype.created_on
    fill_in "Dreyterriumcost", with: @creaturetype.dreyterriumcost
    fill_in "Name", with: @creaturetype.name
    click_on "Create Creaturetype"

    assert_text "Creaturetype was successfully created"
    click_on "Back"
  end

  test "updating a Creaturetype" do
    visit creaturetypes_url
    click_on "Edit", match: :first

    fill_in "Basecost", with: @creaturetype.basecost
    fill_in "Created on", with: @creaturetype.created_on
    fill_in "Dreyterriumcost", with: @creaturetype.dreyterriumcost
    fill_in "Name", with: @creaturetype.name
    click_on "Update Creaturetype"

    assert_text "Creaturetype was successfully updated"
    click_on "Back"
  end

  test "destroying a Creaturetype" do
    visit creaturetypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Creaturetype was successfully destroyed"
  end
end
