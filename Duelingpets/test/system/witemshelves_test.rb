require "application_system_test_case"

class WitemshelvesTest < ApplicationSystemTestCase
  setup do
    @witemshelf = witemshelves(:one)
  end

  test "visiting the index" do
    visit witemshelves_url
    assert_selector "h1", text: "Witemshelves"
  end

  test "creating a Witemshelf" do
    visit witemshelves_url
    click_on "New Witemshelf"

    fill_in "Item10", with: @witemshelf.item10_id
    fill_in "Item11", with: @witemshelf.item11_id
    fill_in "Item12", with: @witemshelf.item12_id
    fill_in "Item13", with: @witemshelf.item13_id
    fill_in "Item14", with: @witemshelf.item14_id
    fill_in "Item15", with: @witemshelf.item15_id
    fill_in "Item16", with: @witemshelf.item16_id
    fill_in "Item17", with: @witemshelf.item17_id
    fill_in "Item18", with: @witemshelf.item18_id
    fill_in "Item19", with: @witemshelf.item19_id
    fill_in "Item1", with: @witemshelf.item1_id
    fill_in "Item20", with: @witemshelf.item20_id
    fill_in "Item21", with: @witemshelf.item21_id
    fill_in "Item22", with: @witemshelf.item22_id
    fill_in "Item23", with: @witemshelf.item23_id
    fill_in "Item24", with: @witemshelf.item24_id
    fill_in "Item25", with: @witemshelf.item25_id
    fill_in "Item26", with: @witemshelf.item26_id
    fill_in "Item27", with: @witemshelf.item27_id
    fill_in "Item28", with: @witemshelf.item28_id
    fill_in "Item29", with: @witemshelf.item29_id
    fill_in "Item2", with: @witemshelf.item2_id
    fill_in "Item30", with: @witemshelf.item30_id
    fill_in "Item3", with: @witemshelf.item3_id
    fill_in "Item4", with: @witemshelf.item4_id
    fill_in "Item5", with: @witemshelf.item5_id
    fill_in "Item6", with: @witemshelf.item6_id
    fill_in "Item7", with: @witemshelf.item7_id
    fill_in "Item8", with: @witemshelf.item8_id
    fill_in "Item9", with: @witemshelf.item9_id
    fill_in "Name", with: @witemshelf.name
    fill_in "Qty1", with: @witemshelf.qty1
    fill_in "Qty10", with: @witemshelf.qty10
    fill_in "Qty11", with: @witemshelf.qty11
    fill_in "Qty12", with: @witemshelf.qty12
    fill_in "Qty13", with: @witemshelf.qty13
    fill_in "Qty14", with: @witemshelf.qty14
    fill_in "Qty15", with: @witemshelf.qty15
    fill_in "Qty16", with: @witemshelf.qty16
    fill_in "Qty17", with: @witemshelf.qty17
    fill_in "Qty18", with: @witemshelf.qty18
    fill_in "Qty19", with: @witemshelf.qty19
    fill_in "Qty2", with: @witemshelf.qty2
    fill_in "Qty20", with: @witemshelf.qty20
    fill_in "Qty21", with: @witemshelf.qty21
    fill_in "Qty22", with: @witemshelf.qty22
    fill_in "Qty23", with: @witemshelf.qty23
    fill_in "Qty24", with: @witemshelf.qty24
    fill_in "Qty25", with: @witemshelf.qty25
    fill_in "Qty26", with: @witemshelf.qty26
    fill_in "Qty27", with: @witemshelf.qty27
    fill_in "Qty28", with: @witemshelf.qty28
    fill_in "Qty29", with: @witemshelf.qty29
    fill_in "Qty3", with: @witemshelf.qty3
    fill_in "Qty30", with: @witemshelf.qty30
    fill_in "Qty4", with: @witemshelf.qty4
    fill_in "Qty5", with: @witemshelf.qty5
    fill_in "Qty6", with: @witemshelf.qty6
    fill_in "Qty7", with: @witemshelf.qty7
    fill_in "Qty8", with: @witemshelf.qty8
    fill_in "Qty9", with: @witemshelf.qty9
    fill_in "Tax1", with: @witemshelf.tax1
    fill_in "Tax10", with: @witemshelf.tax10
    fill_in "Tax11", with: @witemshelf.tax11
    fill_in "Tax12", with: @witemshelf.tax12
    fill_in "Tax13", with: @witemshelf.tax13
    fill_in "Tax14", with: @witemshelf.tax14
    fill_in "Tax15", with: @witemshelf.tax15
    fill_in "Tax16", with: @witemshelf.tax16
    fill_in "Tax17", with: @witemshelf.tax17
    fill_in "Tax18", with: @witemshelf.tax18
    fill_in "Tax19", with: @witemshelf.tax19
    fill_in "Tax2", with: @witemshelf.tax2
    fill_in "Tax20", with: @witemshelf.tax20
    fill_in "Tax21", with: @witemshelf.tax21
    fill_in "Tax22", with: @witemshelf.tax22
    fill_in "Tax23", with: @witemshelf.tax23
    fill_in "Tax24", with: @witemshelf.tax24
    fill_in "Tax25", with: @witemshelf.tax25
    fill_in "Tax26", with: @witemshelf.tax26
    fill_in "Tax27", with: @witemshelf.tax27
    fill_in "Tax28", with: @witemshelf.tax28
    fill_in "Tax29", with: @witemshelf.tax29
    fill_in "Tax3", with: @witemshelf.tax3
    fill_in "Tax30", with: @witemshelf.tax30
    fill_in "Tax4", with: @witemshelf.tax4
    fill_in "Tax5", with: @witemshelf.tax5
    fill_in "Tax6", with: @witemshelf.tax6
    fill_in "Tax7", with: @witemshelf.tax7
    fill_in "Tax8", with: @witemshelf.tax8
    fill_in "Tax9", with: @witemshelf.tax9
    fill_in "Warehouse", with: @witemshelf.warehouse_id
    click_on "Create Witemshelf"

    assert_text "Witemshelf was successfully created"
    click_on "Back"
  end

  test "updating a Witemshelf" do
    visit witemshelves_url
    click_on "Edit", match: :first

    fill_in "Item10", with: @witemshelf.item10_id
    fill_in "Item11", with: @witemshelf.item11_id
    fill_in "Item12", with: @witemshelf.item12_id
    fill_in "Item13", with: @witemshelf.item13_id
    fill_in "Item14", with: @witemshelf.item14_id
    fill_in "Item15", with: @witemshelf.item15_id
    fill_in "Item16", with: @witemshelf.item16_id
    fill_in "Item17", with: @witemshelf.item17_id
    fill_in "Item18", with: @witemshelf.item18_id
    fill_in "Item19", with: @witemshelf.item19_id
    fill_in "Item1", with: @witemshelf.item1_id
    fill_in "Item20", with: @witemshelf.item20_id
    fill_in "Item21", with: @witemshelf.item21_id
    fill_in "Item22", with: @witemshelf.item22_id
    fill_in "Item23", with: @witemshelf.item23_id
    fill_in "Item24", with: @witemshelf.item24_id
    fill_in "Item25", with: @witemshelf.item25_id
    fill_in "Item26", with: @witemshelf.item26_id
    fill_in "Item27", with: @witemshelf.item27_id
    fill_in "Item28", with: @witemshelf.item28_id
    fill_in "Item29", with: @witemshelf.item29_id
    fill_in "Item2", with: @witemshelf.item2_id
    fill_in "Item30", with: @witemshelf.item30_id
    fill_in "Item3", with: @witemshelf.item3_id
    fill_in "Item4", with: @witemshelf.item4_id
    fill_in "Item5", with: @witemshelf.item5_id
    fill_in "Item6", with: @witemshelf.item6_id
    fill_in "Item7", with: @witemshelf.item7_id
    fill_in "Item8", with: @witemshelf.item8_id
    fill_in "Item9", with: @witemshelf.item9_id
    fill_in "Name", with: @witemshelf.name
    fill_in "Qty1", with: @witemshelf.qty1
    fill_in "Qty10", with: @witemshelf.qty10
    fill_in "Qty11", with: @witemshelf.qty11
    fill_in "Qty12", with: @witemshelf.qty12
    fill_in "Qty13", with: @witemshelf.qty13
    fill_in "Qty14", with: @witemshelf.qty14
    fill_in "Qty15", with: @witemshelf.qty15
    fill_in "Qty16", with: @witemshelf.qty16
    fill_in "Qty17", with: @witemshelf.qty17
    fill_in "Qty18", with: @witemshelf.qty18
    fill_in "Qty19", with: @witemshelf.qty19
    fill_in "Qty2", with: @witemshelf.qty2
    fill_in "Qty20", with: @witemshelf.qty20
    fill_in "Qty21", with: @witemshelf.qty21
    fill_in "Qty22", with: @witemshelf.qty22
    fill_in "Qty23", with: @witemshelf.qty23
    fill_in "Qty24", with: @witemshelf.qty24
    fill_in "Qty25", with: @witemshelf.qty25
    fill_in "Qty26", with: @witemshelf.qty26
    fill_in "Qty27", with: @witemshelf.qty27
    fill_in "Qty28", with: @witemshelf.qty28
    fill_in "Qty29", with: @witemshelf.qty29
    fill_in "Qty3", with: @witemshelf.qty3
    fill_in "Qty30", with: @witemshelf.qty30
    fill_in "Qty4", with: @witemshelf.qty4
    fill_in "Qty5", with: @witemshelf.qty5
    fill_in "Qty6", with: @witemshelf.qty6
    fill_in "Qty7", with: @witemshelf.qty7
    fill_in "Qty8", with: @witemshelf.qty8
    fill_in "Qty9", with: @witemshelf.qty9
    fill_in "Tax1", with: @witemshelf.tax1
    fill_in "Tax10", with: @witemshelf.tax10
    fill_in "Tax11", with: @witemshelf.tax11
    fill_in "Tax12", with: @witemshelf.tax12
    fill_in "Tax13", with: @witemshelf.tax13
    fill_in "Tax14", with: @witemshelf.tax14
    fill_in "Tax15", with: @witemshelf.tax15
    fill_in "Tax16", with: @witemshelf.tax16
    fill_in "Tax17", with: @witemshelf.tax17
    fill_in "Tax18", with: @witemshelf.tax18
    fill_in "Tax19", with: @witemshelf.tax19
    fill_in "Tax2", with: @witemshelf.tax2
    fill_in "Tax20", with: @witemshelf.tax20
    fill_in "Tax21", with: @witemshelf.tax21
    fill_in "Tax22", with: @witemshelf.tax22
    fill_in "Tax23", with: @witemshelf.tax23
    fill_in "Tax24", with: @witemshelf.tax24
    fill_in "Tax25", with: @witemshelf.tax25
    fill_in "Tax26", with: @witemshelf.tax26
    fill_in "Tax27", with: @witemshelf.tax27
    fill_in "Tax28", with: @witemshelf.tax28
    fill_in "Tax29", with: @witemshelf.tax29
    fill_in "Tax3", with: @witemshelf.tax3
    fill_in "Tax30", with: @witemshelf.tax30
    fill_in "Tax4", with: @witemshelf.tax4
    fill_in "Tax5", with: @witemshelf.tax5
    fill_in "Tax6", with: @witemshelf.tax6
    fill_in "Tax7", with: @witemshelf.tax7
    fill_in "Tax8", with: @witemshelf.tax8
    fill_in "Tax9", with: @witemshelf.tax9
    fill_in "Warehouse", with: @witemshelf.warehouse_id
    click_on "Update Witemshelf"

    assert_text "Witemshelf was successfully updated"
    click_on "Back"
  end

  test "destroying a Witemshelf" do
    visit witemshelves_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Witemshelf was successfully destroyed"
  end
end
