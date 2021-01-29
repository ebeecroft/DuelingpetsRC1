require "application_system_test_case"

class DragonhoardsTest < ApplicationSystemTestCase
  setup do
    @dragonhoard = dragonhoards(:one)
  end

  test "visiting the index" do
    visit dragonhoards_url
    assert_selector "h1", text: "Dragonhoards"
  end

  test "creating a Dragonhoard" do
    visit dragonhoards_url
    click_on "New Dragonhoard"

    fill_in "Blogadbannercost", with: @dragonhoard.blogadbannercost
    fill_in "Bloglargeimagecost", with: @dragonhoard.bloglargeimagecost
    fill_in "Blogmusiccost", with: @dragonhoard.blogmusiccost
    fill_in "Blogpoints", with: @dragonhoard.blogpoints
    fill_in "Blogsmallimagecost", with: @dragonhoard.blogsmallimagecost
    fill_in "Colorschemecleanup", with: @dragonhoard.colorschemecleanup
    fill_in "Colorschemepoints", with: @dragonhoard.colorschemepoints
    fill_in "Contestpoints", with: @dragonhoard.contestpoints
    fill_in "Conversioncost", with: @dragonhoard.conversioncost
    fill_in "Created on", with: @dragonhoard.created_on
    check "Denholiday" if @dragonhoard.denholiday
    fill_in "Dragonimage", with: @dragonhoard.dragonimage
    fill_in "Dreyterrium extracted", with: @dragonhoard.dreyterrium_extracted
    fill_in "Dreyterrium start", with: @dragonhoard.dreyterrium_start
    fill_in "Dreyterriumbasepoints", with: @dragonhoard.dreyterriumbasepoints
    fill_in "Dreyterriumchange", with: @dragonhoard.dreyterriumchange
    fill_in "Dreyterriumcurrent value", with: @dragonhoard.dreyterriumcurrent_value
    fill_in "Emeraldrate", with: @dragonhoard.emeraldrate
    fill_in "Emeraldvalue", with: @dragonhoard.emeraldvalue
    fill_in "Message", with: @dragonhoard.message
    fill_in "Mp3", with: @dragonhoard.mp3
    fill_in "Name", with: @dragonhoard.name
    fill_in "Newdreyterriumcapacity", with: @dragonhoard.newdreyterriumcapacity
    fill_in "Ogg", with: @dragonhoard.ogg
    fill_in "Pointscreated", with: @dragonhoard.pointscreated
    fill_in "Profit", with: @dragonhoard.profit
    fill_in "Taxbase", with: @dragonhoard.taxbase
    fill_in "Taxinc", with: @dragonhoard.taxinc
    fill_in "Treasury", with: @dragonhoard.treasury
    click_on "Create Dragonhoard"

    assert_text "Dragonhoard was successfully created"
    click_on "Back"
  end

  test "updating a Dragonhoard" do
    visit dragonhoards_url
    click_on "Edit", match: :first

    fill_in "Blogadbannercost", with: @dragonhoard.blogadbannercost
    fill_in "Bloglargeimagecost", with: @dragonhoard.bloglargeimagecost
    fill_in "Blogmusiccost", with: @dragonhoard.blogmusiccost
    fill_in "Blogpoints", with: @dragonhoard.blogpoints
    fill_in "Blogsmallimagecost", with: @dragonhoard.blogsmallimagecost
    fill_in "Colorschemecleanup", with: @dragonhoard.colorschemecleanup
    fill_in "Colorschemepoints", with: @dragonhoard.colorschemepoints
    fill_in "Contestpoints", with: @dragonhoard.contestpoints
    fill_in "Conversioncost", with: @dragonhoard.conversioncost
    fill_in "Created on", with: @dragonhoard.created_on
    check "Denholiday" if @dragonhoard.denholiday
    fill_in "Dragonimage", with: @dragonhoard.dragonimage
    fill_in "Dreyterrium extracted", with: @dragonhoard.dreyterrium_extracted
    fill_in "Dreyterrium start", with: @dragonhoard.dreyterrium_start
    fill_in "Dreyterriumbasepoints", with: @dragonhoard.dreyterriumbasepoints
    fill_in "Dreyterriumchange", with: @dragonhoard.dreyterriumchange
    fill_in "Dreyterriumcurrent value", with: @dragonhoard.dreyterriumcurrent_value
    fill_in "Emeraldrate", with: @dragonhoard.emeraldrate
    fill_in "Emeraldvalue", with: @dragonhoard.emeraldvalue
    fill_in "Message", with: @dragonhoard.message
    fill_in "Mp3", with: @dragonhoard.mp3
    fill_in "Name", with: @dragonhoard.name
    fill_in "Newdreyterriumcapacity", with: @dragonhoard.newdreyterriumcapacity
    fill_in "Ogg", with: @dragonhoard.ogg
    fill_in "Pointscreated", with: @dragonhoard.pointscreated
    fill_in "Profit", with: @dragonhoard.profit
    fill_in "Taxbase", with: @dragonhoard.taxbase
    fill_in "Taxinc", with: @dragonhoard.taxinc
    fill_in "Treasury", with: @dragonhoard.treasury
    click_on "Update Dragonhoard"

    assert_text "Dragonhoard was successfully updated"
    click_on "Back"
  end

  test "destroying a Dragonhoard" do
    visit dragonhoards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dragonhoard was successfully destroyed"
  end
end
