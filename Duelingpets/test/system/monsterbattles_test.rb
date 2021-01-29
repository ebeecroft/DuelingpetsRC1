require "application_system_test_case"

class MonsterbattlesTest < ApplicationSystemTestCase
  setup do
    @monsterbattle = monsterbattles(:one)
  end

  test "visiting the index" do
    visit monsterbattles_url
    assert_selector "h1", text: "Monsterbattles"
  end

  test "creating a Monsterbattle" do
    visit monsterbattles_url
    click_on "New Monsterbattle"

    check "Battleover" if @monsterbattle.battleover
    fill_in "Creaturetype", with: @monsterbattle.creaturetype_id
    fill_in "Dreyore earned", with: @monsterbattle.dreyore_earned
    fill_in "Ended on", with: @monsterbattle.ended_on
    fill_in "Exp earned", with: @monsterbattle.exp_earned
    fill_in "Items earned", with: @monsterbattle.items_earned
    fill_in "Monster agility", with: @monsterbattle.monster_agility
    fill_in "Monster atk", with: @monsterbattle.monster_atk
    fill_in "Monster chp", with: @monsterbattle.monster_chp
    fill_in "Monster cmp", with: @monsterbattle.monster_cmp
    fill_in "Monster damage", with: @monsterbattle.monster_damage
    fill_in "Monster def", with: @monsterbattle.monster_def
    fill_in "Monster hp", with: @monsterbattle.monster_hp
    fill_in "Monster", with: @monsterbattle.monster_id
    fill_in "Monster loot", with: @monsterbattle.monster_loot
    fill_in "Monster magi", with: @monsterbattle.monster_magi
    fill_in "Monster matk", with: @monsterbattle.monster_matk
    fill_in "Monster mdef", with: @monsterbattle.monster_mdef
    fill_in "Monster mischief", with: @monsterbattle.monster_mischief
    fill_in "Monster mlevel", with: @monsterbattle.monster_mlevel
    fill_in "Monster mp", with: @monsterbattle.monster_mp
    fill_in "Monster name", with: @monsterbattle.monster_name
    fill_in "Monster plevel", with: @monsterbattle.monster_plevel
    fill_in "Monster rarity", with: @monsterbattle.monster_rarity
    fill_in "Monstertype", with: @monsterbattle.monstertype_id
    check "Partner activepet" if @monsterbattle.partner_activepet
    fill_in "Partner agility", with: @monsterbattle.partner_agility
    fill_in "Partner atk", with: @monsterbattle.partner_atk
    fill_in "Partner chp", with: @monsterbattle.partner_chp
    fill_in "Partner cmp", with: @monsterbattle.partner_cmp
    fill_in "Partner damage", with: @monsterbattle.partner_damage
    fill_in "Partner def", with: @monsterbattle.partner_def
    fill_in "Partner hp", with: @monsterbattle.partner_hp
    fill_in "Partner", with: @monsterbattle.partner_id
    fill_in "Partner lives", with: @monsterbattle.partner_lives
    fill_in "Partner magi", with: @monsterbattle.partner_magi
    fill_in "Partner matk", with: @monsterbattle.partner_matk
    fill_in "Partner mdef", with: @monsterbattle.partner_mdef
    fill_in "Partner mexp", with: @monsterbattle.partner_mexp
    fill_in "Partner mlevel", with: @monsterbattle.partner_mlevel
    fill_in "Partner mp", with: @monsterbattle.partner_mp
    fill_in "Partner mstr", with: @monsterbattle.partner_mstr
    fill_in "Partner name", with: @monsterbattle.partner_name
    fill_in "Partner pexp", with: @monsterbattle.partner_pexp
    fill_in "Partner plevel", with: @monsterbattle.partner_plevel
    fill_in "Partner rarity", with: @monsterbattle.partner_rarity
    fill_in "Partner strength", with: @monsterbattle.partner_strength
    fill_in "Round", with: @monsterbattle.round
    fill_in "Started on", with: @monsterbattle.started_on
    fill_in "Tokens earned", with: @monsterbattle.tokens_earned
    click_on "Create Monsterbattle"

    assert_text "Monsterbattle was successfully created"
    click_on "Back"
  end

  test "updating a Monsterbattle" do
    visit monsterbattles_url
    click_on "Edit", match: :first

    check "Battleover" if @monsterbattle.battleover
    fill_in "Creaturetype", with: @monsterbattle.creaturetype_id
    fill_in "Dreyore earned", with: @monsterbattle.dreyore_earned
    fill_in "Ended on", with: @monsterbattle.ended_on
    fill_in "Exp earned", with: @monsterbattle.exp_earned
    fill_in "Items earned", with: @monsterbattle.items_earned
    fill_in "Monster agility", with: @monsterbattle.monster_agility
    fill_in "Monster atk", with: @monsterbattle.monster_atk
    fill_in "Monster chp", with: @monsterbattle.monster_chp
    fill_in "Monster cmp", with: @monsterbattle.monster_cmp
    fill_in "Monster damage", with: @monsterbattle.monster_damage
    fill_in "Monster def", with: @monsterbattle.monster_def
    fill_in "Monster hp", with: @monsterbattle.monster_hp
    fill_in "Monster", with: @monsterbattle.monster_id
    fill_in "Monster loot", with: @monsterbattle.monster_loot
    fill_in "Monster magi", with: @monsterbattle.monster_magi
    fill_in "Monster matk", with: @monsterbattle.monster_matk
    fill_in "Monster mdef", with: @monsterbattle.monster_mdef
    fill_in "Monster mischief", with: @monsterbattle.monster_mischief
    fill_in "Monster mlevel", with: @monsterbattle.monster_mlevel
    fill_in "Monster mp", with: @monsterbattle.monster_mp
    fill_in "Monster name", with: @monsterbattle.monster_name
    fill_in "Monster plevel", with: @monsterbattle.monster_plevel
    fill_in "Monster rarity", with: @monsterbattle.monster_rarity
    fill_in "Monstertype", with: @monsterbattle.monstertype_id
    check "Partner activepet" if @monsterbattle.partner_activepet
    fill_in "Partner agility", with: @monsterbattle.partner_agility
    fill_in "Partner atk", with: @monsterbattle.partner_atk
    fill_in "Partner chp", with: @monsterbattle.partner_chp
    fill_in "Partner cmp", with: @monsterbattle.partner_cmp
    fill_in "Partner damage", with: @monsterbattle.partner_damage
    fill_in "Partner def", with: @monsterbattle.partner_def
    fill_in "Partner hp", with: @monsterbattle.partner_hp
    fill_in "Partner", with: @monsterbattle.partner_id
    fill_in "Partner lives", with: @monsterbattle.partner_lives
    fill_in "Partner magi", with: @monsterbattle.partner_magi
    fill_in "Partner matk", with: @monsterbattle.partner_matk
    fill_in "Partner mdef", with: @monsterbattle.partner_mdef
    fill_in "Partner mexp", with: @monsterbattle.partner_mexp
    fill_in "Partner mlevel", with: @monsterbattle.partner_mlevel
    fill_in "Partner mp", with: @monsterbattle.partner_mp
    fill_in "Partner mstr", with: @monsterbattle.partner_mstr
    fill_in "Partner name", with: @monsterbattle.partner_name
    fill_in "Partner pexp", with: @monsterbattle.partner_pexp
    fill_in "Partner plevel", with: @monsterbattle.partner_plevel
    fill_in "Partner rarity", with: @monsterbattle.partner_rarity
    fill_in "Partner strength", with: @monsterbattle.partner_strength
    fill_in "Round", with: @monsterbattle.round
    fill_in "Started on", with: @monsterbattle.started_on
    fill_in "Tokens earned", with: @monsterbattle.tokens_earned
    click_on "Update Monsterbattle"

    assert_text "Monsterbattle was successfully updated"
    click_on "Back"
  end

  test "destroying a Monsterbattle" do
    visit monsterbattles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monsterbattle was successfully destroyed"
  end
end
