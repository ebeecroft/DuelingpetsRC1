require "application_system_test_case"

class PartnersTest < ApplicationSystemTestCase
  setup do
    @partner = partners(:one)
  end

  test "visiting the index" do
    visit partners_url
    assert_selector "h1", text: "Partners"
  end

  test "creating a Partner" do
    visit partners_url
    click_on "New Partner"

    check "Activepet" if @partner.activepet
    fill_in "Adoptcost", with: @partner.adoptcost
    fill_in "Adopted on", with: @partner.adopted_on
    fill_in "Agility", with: @partner.agility
    fill_in "Atk", with: @partner.atk
    fill_in "Cfun", with: @partner.cfun
    fill_in "Chp", with: @partner.chp
    fill_in "Chunger", with: @partner.chunger
    fill_in "Cmp", with: @partner.cmp
    fill_in "Cost", with: @partner.cost
    fill_in "Creature", with: @partner.creature_id
    fill_in "Cthirst", with: @partner.cthirst
    check "Dead" if @partner.dead
    fill_in "Def", with: @partner.def
    fill_in "Description", with: @partner.description
    fill_in "Fun", with: @partner.fun
    fill_in "Hp", with: @partner.hp
    fill_in "Hunger", with: @partner.hunger
    check "Inbattle" if @partner.inbattle
    fill_in "Lives", with: @partner.lives
    fill_in "Magi", with: @partner.magi
    fill_in "Magitokens", with: @partner.magitokens
    fill_in "Matk", with: @partner.matk
    fill_in "Mdef", with: @partner.mdef
    fill_in "Mexp", with: @partner.mexp
    fill_in "Mlevel", with: @partner.mlevel
    fill_in "Mp", with: @partner.mp
    fill_in "Mstr", with: @partner.mstr
    fill_in "Name", with: @partner.name
    fill_in "Pexp", with: @partner.pexp
    fill_in "Phytokens", with: @partner.phytokens
    fill_in "Plevel", with: @partner.plevel
    fill_in "Strength", with: @partner.strength
    fill_in "Thirst", with: @partner.thirst
    fill_in "Updated on", with: @partner.updated_on
    fill_in "User", with: @partner.user_id
    click_on "Create Partner"

    assert_text "Partner was successfully created"
    click_on "Back"
  end

  test "updating a Partner" do
    visit partners_url
    click_on "Edit", match: :first

    check "Activepet" if @partner.activepet
    fill_in "Adoptcost", with: @partner.adoptcost
    fill_in "Adopted on", with: @partner.adopted_on
    fill_in "Agility", with: @partner.agility
    fill_in "Atk", with: @partner.atk
    fill_in "Cfun", with: @partner.cfun
    fill_in "Chp", with: @partner.chp
    fill_in "Chunger", with: @partner.chunger
    fill_in "Cmp", with: @partner.cmp
    fill_in "Cost", with: @partner.cost
    fill_in "Creature", with: @partner.creature_id
    fill_in "Cthirst", with: @partner.cthirst
    check "Dead" if @partner.dead
    fill_in "Def", with: @partner.def
    fill_in "Description", with: @partner.description
    fill_in "Fun", with: @partner.fun
    fill_in "Hp", with: @partner.hp
    fill_in "Hunger", with: @partner.hunger
    check "Inbattle" if @partner.inbattle
    fill_in "Lives", with: @partner.lives
    fill_in "Magi", with: @partner.magi
    fill_in "Magitokens", with: @partner.magitokens
    fill_in "Matk", with: @partner.matk
    fill_in "Mdef", with: @partner.mdef
    fill_in "Mexp", with: @partner.mexp
    fill_in "Mlevel", with: @partner.mlevel
    fill_in "Mp", with: @partner.mp
    fill_in "Mstr", with: @partner.mstr
    fill_in "Name", with: @partner.name
    fill_in "Pexp", with: @partner.pexp
    fill_in "Phytokens", with: @partner.phytokens
    fill_in "Plevel", with: @partner.plevel
    fill_in "Strength", with: @partner.strength
    fill_in "Thirst", with: @partner.thirst
    fill_in "Updated on", with: @partner.updated_on
    fill_in "User", with: @partner.user_id
    click_on "Update Partner"

    assert_text "Partner was successfully updated"
    click_on "Back"
  end

  test "destroying a Partner" do
    visit partners_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Partner was successfully destroyed"
  end
end
