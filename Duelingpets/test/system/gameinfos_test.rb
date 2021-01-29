require "application_system_test_case"

class GameinfosTest < ApplicationSystemTestCase
  setup do
    @gameinfo = gameinfos(:one)
  end

  test "visiting the index" do
    visit gameinfos_url
    assert_selector "h1", text: "Gameinfos"
  end

  test "creating a Gameinfo" do
    visit gameinfos_url
    click_on "New Gameinfo"

    fill_in "Activated on", with: @gameinfo.activated_on
    check "Ageing enabled" if @gameinfo.ageing_enabled
    fill_in "Difficulty", with: @gameinfo.difficulty_id
    fill_in "Failure", with: @gameinfo.failure
    check "Gamecompleted" if @gameinfo.gamecompleted
    check "Lives enabled" if @gameinfo.lives_enabled
    check "Startgame" if @gameinfo.startgame
    fill_in "Success", with: @gameinfo.success
    click_on "Create Gameinfo"

    assert_text "Gameinfo was successfully created"
    click_on "Back"
  end

  test "updating a Gameinfo" do
    visit gameinfos_url
    click_on "Edit", match: :first

    fill_in "Activated on", with: @gameinfo.activated_on
    check "Ageing enabled" if @gameinfo.ageing_enabled
    fill_in "Difficulty", with: @gameinfo.difficulty_id
    fill_in "Failure", with: @gameinfo.failure
    check "Gamecompleted" if @gameinfo.gamecompleted
    check "Lives enabled" if @gameinfo.lives_enabled
    check "Startgame" if @gameinfo.startgame
    fill_in "Success", with: @gameinfo.success
    click_on "Update Gameinfo"

    assert_text "Gameinfo was successfully updated"
    click_on "Back"
  end

  test "destroying a Gameinfo" do
    visit gameinfos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Gameinfo was successfully destroyed"
  end
end
