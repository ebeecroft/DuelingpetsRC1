require "application_system_test_case"

class CreaturesTest < ApplicationSystemTestCase
  setup do
    @creature = creatures(:one)
  end

  test "visiting the index" do
    visit creatures_url
    assert_selector "h1", text: "Creatures"
  end

  test "creating a Creature" do
    visit creatures_url
    click_on "New Creature"

    fill_in "Atk", with: @creature.atk
    fill_in "Charms", with: @creature.charms
    fill_in "Chubbyness", with: @creature.chubbyness
    fill_in "Concealment", with: @creature.concealment
    fill_in "Cost", with: @creature.cost
    fill_in "Created on", with: @creature.created_on
    fill_in "Creaturetype", with: @creature.creaturetype_id
    fill_in "Def", with: @creature.def
    fill_in "Description", with: @creature.description
    fill_in "Flow", with: @creature.flow
    fill_in "Force", with: @creature.force
    fill_in "Hp", with: @creature.hp
    fill_in "Hunger", with: @creature.hunger
    fill_in "Image", with: @creature.image
    fill_in "Level", with: @creature.level
    fill_in "Lives", with: @creature.lives
    fill_in "Luck", with: @creature.luck
    fill_in "Mp", with: @creature.mp
    fill_in "Mp3", with: @creature.mp3
    fill_in "Name", with: @creature.name
    fill_in "Ogg", with: @creature.ogg
    fill_in "Petworth", with: @creature.petworth
    fill_in "Power", with: @creature.power
    fill_in "Rarity", with: @creature.rarity
    check "Reviewed" if @creature.reviewed
    fill_in "Reviewed on", with: @creature.reviewed_on
    fill_in "Spd", with: @creature.spd
    check "Starter" if @creature.starter
    fill_in "Strength", with: @creature.strength
    fill_in "Thirst", with: @creature.thirst
    fill_in "Updated on", with: @creature.updated_on
    fill_in "User", with: @creature.user_id
    fill_in "Voicemp3", with: @creature.voicemp3
    fill_in "Voiceogg", with: @creature.voiceogg
    fill_in "Will", with: @creature.will
    click_on "Create Creature"

    assert_text "Creature was successfully created"
    click_on "Back"
  end

  test "updating a Creature" do
    visit creatures_url
    click_on "Edit", match: :first

    fill_in "Atk", with: @creature.atk
    fill_in "Charms", with: @creature.charms
    fill_in "Chubbyness", with: @creature.chubbyness
    fill_in "Concealment", with: @creature.concealment
    fill_in "Cost", with: @creature.cost
    fill_in "Created on", with: @creature.created_on
    fill_in "Creaturetype", with: @creature.creaturetype_id
    fill_in "Def", with: @creature.def
    fill_in "Description", with: @creature.description
    fill_in "Flow", with: @creature.flow
    fill_in "Force", with: @creature.force
    fill_in "Hp", with: @creature.hp
    fill_in "Hunger", with: @creature.hunger
    fill_in "Image", with: @creature.image
    fill_in "Level", with: @creature.level
    fill_in "Lives", with: @creature.lives
    fill_in "Luck", with: @creature.luck
    fill_in "Mp", with: @creature.mp
    fill_in "Mp3", with: @creature.mp3
    fill_in "Name", with: @creature.name
    fill_in "Ogg", with: @creature.ogg
    fill_in "Petworth", with: @creature.petworth
    fill_in "Power", with: @creature.power
    fill_in "Rarity", with: @creature.rarity
    check "Reviewed" if @creature.reviewed
    fill_in "Reviewed on", with: @creature.reviewed_on
    fill_in "Spd", with: @creature.spd
    check "Starter" if @creature.starter
    fill_in "Strength", with: @creature.strength
    fill_in "Thirst", with: @creature.thirst
    fill_in "Updated on", with: @creature.updated_on
    fill_in "User", with: @creature.user_id
    fill_in "Voicemp3", with: @creature.voicemp3
    fill_in "Voiceogg", with: @creature.voiceogg
    fill_in "Will", with: @creature.will
    click_on "Update Creature"

    assert_text "Creature was successfully updated"
    click_on "Back"
  end

  test "destroying a Creature" do
    visit creatures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Creature was successfully destroyed"
  end
end
