require "application_system_test_case"

class MonstersTest < ApplicationSystemTestCase
  setup do
    @monster = monsters(:one)
  end

  test "visiting the index" do
    visit monsters_url
    assert_selector "h1", text: "Monsters"
  end

  test "creating a Monster" do
    visit monsters_url
    click_on "New Monster"

    fill_in "Agility", with: @monster.agility
    fill_in "Atk", with: @monster.atk
    fill_in "Created on", with: @monster.created_on
    fill_in "Def", with: @monster.def
    fill_in "Description", with: @monster.description
    fill_in "Exp", with: @monster.exp
    fill_in "Hp", with: @monster.hp
    fill_in "Image", with: @monster.image
    fill_in "Level", with: @monster.level
    fill_in "Loot", with: @monster.loot
    fill_in "Magi", with: @monster.magi
    fill_in "Matk", with: @monster.matk
    fill_in "Mdef", with: @monster.mdef
    fill_in "Mischief", with: @monster.mischief
    fill_in "Monstertype", with: @monster.monstertype_id
    fill_in "Mp", with: @monster.mp
    fill_in "Mp3", with: @monster.mp3
    fill_in "Mstr", with: @monster.mstr
    fill_in "Name", with: @monster.name
    fill_in "Ogg", with: @monster.ogg
    fill_in "Rarity", with: @monster.rarity
    check "Retiredmonster" if @monster.retiredmonster
    check "Reviewed" if @monster.reviewed
    fill_in "Reviewed on", with: @monster.reviewed_on
    fill_in "Strength", with: @monster.strength
    fill_in "Updated on", with: @monster.updated_on
    fill_in "User", with: @monster.user_id
    click_on "Create Monster"

    assert_text "Monster was successfully created"
    click_on "Back"
  end

  test "updating a Monster" do
    visit monsters_url
    click_on "Edit", match: :first

    fill_in "Agility", with: @monster.agility
    fill_in "Atk", with: @monster.atk
    fill_in "Created on", with: @monster.created_on
    fill_in "Def", with: @monster.def
    fill_in "Description", with: @monster.description
    fill_in "Exp", with: @monster.exp
    fill_in "Hp", with: @monster.hp
    fill_in "Image", with: @monster.image
    fill_in "Level", with: @monster.level
    fill_in "Loot", with: @monster.loot
    fill_in "Magi", with: @monster.magi
    fill_in "Matk", with: @monster.matk
    fill_in "Mdef", with: @monster.mdef
    fill_in "Mischief", with: @monster.mischief
    fill_in "Monstertype", with: @monster.monstertype_id
    fill_in "Mp", with: @monster.mp
    fill_in "Mp3", with: @monster.mp3
    fill_in "Mstr", with: @monster.mstr
    fill_in "Name", with: @monster.name
    fill_in "Ogg", with: @monster.ogg
    fill_in "Rarity", with: @monster.rarity
    check "Retiredmonster" if @monster.retiredmonster
    check "Reviewed" if @monster.reviewed
    fill_in "Reviewed on", with: @monster.reviewed_on
    fill_in "Strength", with: @monster.strength
    fill_in "Updated on", with: @monster.updated_on
    fill_in "User", with: @monster.user_id
    click_on "Update Monster"

    assert_text "Monster was successfully updated"
    click_on "Back"
  end

  test "destroying a Monster" do
    visit monsters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monster was successfully destroyed"
  end
end
