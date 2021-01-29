require "application_system_test_case"

class FightsTest < ApplicationSystemTestCase
  setup do
    @fight = fights(:one)
  end

  test "visiting the index" do
    visit fights_url
    assert_selector "h1", text: "Fights"
  end

  test "creating a Fight" do
    visit fights_url
    click_on "New Fight"

    fill_in "Draw", with: @fight.draw
    fill_in "Loss", with: @fight.loss
    fill_in "Partner", with: @fight.partner_id
    fill_in "Win", with: @fight.win
    click_on "Create Fight"

    assert_text "Fight was successfully created"
    click_on "Back"
  end

  test "updating a Fight" do
    visit fights_url
    click_on "Edit", match: :first

    fill_in "Draw", with: @fight.draw
    fill_in "Loss", with: @fight.loss
    fill_in "Partner", with: @fight.partner_id
    fill_in "Win", with: @fight.win
    click_on "Update Fight"

    assert_text "Fight was successfully updated"
    click_on "Back"
  end

  test "destroying a Fight" do
    visit fights_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fight was successfully destroyed"
  end
end
