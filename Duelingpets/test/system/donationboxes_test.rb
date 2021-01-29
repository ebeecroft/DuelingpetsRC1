require "application_system_test_case"

class DonationboxesTest < ApplicationSystemTestCase
  setup do
    @donationbox = donationboxes(:one)
  end

  test "visiting the index" do
    visit donationboxes_url
    assert_selector "h1", text: "Donationboxes"
  end

  test "creating a Donationbox" do
    visit donationboxes_url
    click_on "New Donationbox"

    check "Box open" if @donationbox.box_open
    fill_in "Capacity", with: @donationbox.capacity
    fill_in "Description", with: @donationbox.description
    fill_in "Goal", with: @donationbox.goal
    check "Hitgoal" if @donationbox.hitgoal
    fill_in "Initialized on", with: @donationbox.initialized_on
    fill_in "Progress", with: @donationbox.progress
    fill_in "User", with: @donationbox.user_id
    click_on "Create Donationbox"

    assert_text "Donationbox was successfully created"
    click_on "Back"
  end

  test "updating a Donationbox" do
    visit donationboxes_url
    click_on "Edit", match: :first

    check "Box open" if @donationbox.box_open
    fill_in "Capacity", with: @donationbox.capacity
    fill_in "Description", with: @donationbox.description
    fill_in "Goal", with: @donationbox.goal
    check "Hitgoal" if @donationbox.hitgoal
    fill_in "Initialized on", with: @donationbox.initialized_on
    fill_in "Progress", with: @donationbox.progress
    fill_in "User", with: @donationbox.user_id
    click_on "Update Donationbox"

    assert_text "Donationbox was successfully updated"
    click_on "Back"
  end

  test "destroying a Donationbox" do
    visit donationboxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Donationbox was successfully destroyed"
  end
end
