require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "creating a Item" do
    visit items_url
    click_on "New Item"

    fill_in "Atk", with: @item.atk
    fill_in "Cost", with: @item.cost
    fill_in "Created on", with: @item.created_on
    fill_in "Def", with: @item.def
    fill_in "Description", with: @item.description
    fill_in "Durability", with: @item.durability
    check "Equipable" if @item.equipable
    fill_in "Fun", with: @item.fun
    fill_in "Hp", with: @item.hp
    fill_in "Hunger", with: @item.hunger
    fill_in "Itemart", with: @item.itemart
    fill_in "Itemtype", with: @item.itemtype_id
    fill_in "Knowledge", with: @item.knowledge
    fill_in "Name", with: @item.name
    fill_in "Rarity", with: @item.rarity
    check "Reviewed" if @item.reviewed
    fill_in "Reviewed on", with: @item.reviewed_on
    fill_in "Spd", with: @item.spd
    check "Starter" if @item.starter
    fill_in "Updated on", with: @item.updated_on
    fill_in "User", with: @item.user_id
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit items_url
    click_on "Edit", match: :first

    fill_in "Atk", with: @item.atk
    fill_in "Cost", with: @item.cost
    fill_in "Created on", with: @item.created_on
    fill_in "Def", with: @item.def
    fill_in "Description", with: @item.description
    fill_in "Durability", with: @item.durability
    check "Equipable" if @item.equipable
    fill_in "Fun", with: @item.fun
    fill_in "Hp", with: @item.hp
    fill_in "Hunger", with: @item.hunger
    fill_in "Itemart", with: @item.itemart
    fill_in "Itemtype", with: @item.itemtype_id
    fill_in "Knowledge", with: @item.knowledge
    fill_in "Name", with: @item.name
    fill_in "Rarity", with: @item.rarity
    check "Reviewed" if @item.reviewed
    fill_in "Reviewed on", with: @item.reviewed_on
    fill_in "Spd", with: @item.spd
    check "Starter" if @item.starter
    fill_in "Updated on", with: @item.updated_on
    fill_in "User", with: @item.user_id
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end
