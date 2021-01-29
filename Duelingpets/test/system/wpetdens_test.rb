require "application_system_test_case"

class WpetdensTest < ApplicationSystemTestCase
  setup do
    @wpetden = wpetdens(:one)
  end

  test "visiting the index" do
    visit wpetdens_url
    assert_selector "h1", text: "Wpetdens"
  end

  test "creating a Wpetden" do
    visit wpetdens_url
    click_on "New Wpetden"

    fill_in "Creature10", with: @wpetden.creature10_id
    fill_in "Creature11", with: @wpetden.creature11_id
    fill_in "Creature12", with: @wpetden.creature12_id
    fill_in "Creature13", with: @wpetden.creature13_id
    fill_in "Creature14", with: @wpetden.creature14_id
    fill_in "Creature15", with: @wpetden.creature15_id
    fill_in "Creature16", with: @wpetden.creature16_id
    fill_in "Creature1", with: @wpetden.creature1_id
    fill_in "Creature2", with: @wpetden.creature2_id
    fill_in "Creature3", with: @wpetden.creature3_id
    fill_in "Creature4", with: @wpetden.creature4_id
    fill_in "Creature5", with: @wpetden.creature5_id
    fill_in "Creature6", with: @wpetden.creature6_id
    fill_in "Creature7", with: @wpetden.creature7_id
    fill_in "Creature8", with: @wpetden.creature8_id
    fill_in "Creature9", with: @wpetden.creature9_id
    fill_in "Name", with: @wpetden.name
    fill_in "Qty1", with: @wpetden.qty1
    fill_in "Qty10", with: @wpetden.qty10
    fill_in "Qty11", with: @wpetden.qty11
    fill_in "Qty12", with: @wpetden.qty12
    fill_in "Qty13", with: @wpetden.qty13
    fill_in "Qty14", with: @wpetden.qty14
    fill_in "Qty15", with: @wpetden.qty15
    fill_in "Qty16", with: @wpetden.qty16
    fill_in "Qty2", with: @wpetden.qty2
    fill_in "Qty3", with: @wpetden.qty3
    fill_in "Qty4", with: @wpetden.qty4
    fill_in "Qty5", with: @wpetden.qty5
    fill_in "Qty6", with: @wpetden.qty6
    fill_in "Qty7", with: @wpetden.qty7
    fill_in "Qty8", with: @wpetden.qty8
    fill_in "Qty9", with: @wpetden.qty9
    fill_in "Tax1", with: @wpetden.tax1
    fill_in "Tax10", with: @wpetden.tax10
    fill_in "Tax11", with: @wpetden.tax11
    fill_in "Tax12", with: @wpetden.tax12
    fill_in "Tax13", with: @wpetden.tax13
    fill_in "Tax14", with: @wpetden.tax14
    fill_in "Tax15", with: @wpetden.tax15
    fill_in "Tax16", with: @wpetden.tax16
    fill_in "Tax2", with: @wpetden.tax2
    fill_in "Tax3", with: @wpetden.tax3
    fill_in "Tax4", with: @wpetden.tax4
    fill_in "Tax5", with: @wpetden.tax5
    fill_in "Tax6", with: @wpetden.tax6
    fill_in "Tax7", with: @wpetden.tax7
    fill_in "Tax8", with: @wpetden.tax8
    fill_in "Tax9", with: @wpetden.tax9
    fill_in "Warehouse", with: @wpetden.warehouse_id
    click_on "Create Wpetden"

    assert_text "Wpetden was successfully created"
    click_on "Back"
  end

  test "updating a Wpetden" do
    visit wpetdens_url
    click_on "Edit", match: :first

    fill_in "Creature10", with: @wpetden.creature10_id
    fill_in "Creature11", with: @wpetden.creature11_id
    fill_in "Creature12", with: @wpetden.creature12_id
    fill_in "Creature13", with: @wpetden.creature13_id
    fill_in "Creature14", with: @wpetden.creature14_id
    fill_in "Creature15", with: @wpetden.creature15_id
    fill_in "Creature16", with: @wpetden.creature16_id
    fill_in "Creature1", with: @wpetden.creature1_id
    fill_in "Creature2", with: @wpetden.creature2_id
    fill_in "Creature3", with: @wpetden.creature3_id
    fill_in "Creature4", with: @wpetden.creature4_id
    fill_in "Creature5", with: @wpetden.creature5_id
    fill_in "Creature6", with: @wpetden.creature6_id
    fill_in "Creature7", with: @wpetden.creature7_id
    fill_in "Creature8", with: @wpetden.creature8_id
    fill_in "Creature9", with: @wpetden.creature9_id
    fill_in "Name", with: @wpetden.name
    fill_in "Qty1", with: @wpetden.qty1
    fill_in "Qty10", with: @wpetden.qty10
    fill_in "Qty11", with: @wpetden.qty11
    fill_in "Qty12", with: @wpetden.qty12
    fill_in "Qty13", with: @wpetden.qty13
    fill_in "Qty14", with: @wpetden.qty14
    fill_in "Qty15", with: @wpetden.qty15
    fill_in "Qty16", with: @wpetden.qty16
    fill_in "Qty2", with: @wpetden.qty2
    fill_in "Qty3", with: @wpetden.qty3
    fill_in "Qty4", with: @wpetden.qty4
    fill_in "Qty5", with: @wpetden.qty5
    fill_in "Qty6", with: @wpetden.qty6
    fill_in "Qty7", with: @wpetden.qty7
    fill_in "Qty8", with: @wpetden.qty8
    fill_in "Qty9", with: @wpetden.qty9
    fill_in "Tax1", with: @wpetden.tax1
    fill_in "Tax10", with: @wpetden.tax10
    fill_in "Tax11", with: @wpetden.tax11
    fill_in "Tax12", with: @wpetden.tax12
    fill_in "Tax13", with: @wpetden.tax13
    fill_in "Tax14", with: @wpetden.tax14
    fill_in "Tax15", with: @wpetden.tax15
    fill_in "Tax16", with: @wpetden.tax16
    fill_in "Tax2", with: @wpetden.tax2
    fill_in "Tax3", with: @wpetden.tax3
    fill_in "Tax4", with: @wpetden.tax4
    fill_in "Tax5", with: @wpetden.tax5
    fill_in "Tax6", with: @wpetden.tax6
    fill_in "Tax7", with: @wpetden.tax7
    fill_in "Tax8", with: @wpetden.tax8
    fill_in "Tax9", with: @wpetden.tax9
    fill_in "Warehouse", with: @wpetden.warehouse_id
    click_on "Update Wpetden"

    assert_text "Wpetden was successfully updated"
    click_on "Back"
  end

  test "destroying a Wpetden" do
    visit wpetdens_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wpetden was successfully destroyed"
  end
end
