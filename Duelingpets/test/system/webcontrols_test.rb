require "application_system_test_case"

class WebcontrolsTest < ApplicationSystemTestCase
  setup do
    @webcontrol = webcontrols(:one)
  end

  test "visiting the index" do
    visit webcontrols_url
    assert_selector "h1", text: "Webcontrols"
  end

  test "creating a Webcontrol" do
    visit webcontrols_url
    click_on "New Webcontrol"

    fill_in "Banner", with: @webcontrol.banner
    fill_in "Betamp3", with: @webcontrol.betamp3
    fill_in "Betaogg", with: @webcontrol.betaogg
    fill_in "Created on", with: @webcontrol.created_on
    fill_in "Creationmp3", with: @webcontrol.creationmp3
    fill_in "Creationogg", with: @webcontrol.creationogg
    fill_in "Criticalmp3", with: @webcontrol.criticalmp3
    fill_in "Criticalogg", with: @webcontrol.criticalogg
    fill_in "Daycolor", with: @webcontrol.daycolor_id
    fill_in "Favicon", with: @webcontrol.favicon
    check "Gate open" if @webcontrol.gate_open
    fill_in "Grandmp3", with: @webcontrol.grandmp3
    fill_in "Grandogg", with: @webcontrol.grandogg
    fill_in "Maintenancemp3", with: @webcontrol.maintenancemp3
    fill_in "Maintenanceogg", with: @webcontrol.maintenanceogg
    fill_in "Mascot", with: @webcontrol.mascot
    fill_in "Mp3", with: @webcontrol.mp3
    fill_in "Nightcolor", with: @webcontrol.nightcolor_id
    fill_in "Ogg", with: @webcontrol.ogg
    click_on "Create Webcontrol"

    assert_text "Webcontrol was successfully created"
    click_on "Back"
  end

  test "updating a Webcontrol" do
    visit webcontrols_url
    click_on "Edit", match: :first

    fill_in "Banner", with: @webcontrol.banner
    fill_in "Betamp3", with: @webcontrol.betamp3
    fill_in "Betaogg", with: @webcontrol.betaogg
    fill_in "Created on", with: @webcontrol.created_on
    fill_in "Creationmp3", with: @webcontrol.creationmp3
    fill_in "Creationogg", with: @webcontrol.creationogg
    fill_in "Criticalmp3", with: @webcontrol.criticalmp3
    fill_in "Criticalogg", with: @webcontrol.criticalogg
    fill_in "Daycolor", with: @webcontrol.daycolor_id
    fill_in "Favicon", with: @webcontrol.favicon
    check "Gate open" if @webcontrol.gate_open
    fill_in "Grandmp3", with: @webcontrol.grandmp3
    fill_in "Grandogg", with: @webcontrol.grandogg
    fill_in "Maintenancemp3", with: @webcontrol.maintenancemp3
    fill_in "Maintenanceogg", with: @webcontrol.maintenanceogg
    fill_in "Mascot", with: @webcontrol.mascot
    fill_in "Mp3", with: @webcontrol.mp3
    fill_in "Nightcolor", with: @webcontrol.nightcolor_id
    fill_in "Ogg", with: @webcontrol.ogg
    click_on "Update Webcontrol"

    assert_text "Webcontrol was successfully updated"
    click_on "Back"
  end

  test "destroying a Webcontrol" do
    visit webcontrols_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Webcontrol was successfully destroyed"
  end
end
