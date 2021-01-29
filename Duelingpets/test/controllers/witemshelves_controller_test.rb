require 'test_helper'

class WitemshelvesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @witemshelf = witemshelves(:one)
  end

  test "should get index" do
    get witemshelves_url
    assert_response :success
  end

  test "should get new" do
    get new_witemshelf_url
    assert_response :success
  end

  test "should create witemshelf" do
    assert_difference('Witemshelf.count') do
      post witemshelves_url, params: { witemshelf: { item10_id: @witemshelf.item10_id, item11_id: @witemshelf.item11_id, item12_id: @witemshelf.item12_id, item13_id: @witemshelf.item13_id, item14_id: @witemshelf.item14_id, item15_id: @witemshelf.item15_id, item16_id: @witemshelf.item16_id, item17_id: @witemshelf.item17_id, item18_id: @witemshelf.item18_id, item19_id: @witemshelf.item19_id, item1_id: @witemshelf.item1_id, item20_id: @witemshelf.item20_id, item21_id: @witemshelf.item21_id, item22_id: @witemshelf.item22_id, item23_id: @witemshelf.item23_id, item24_id: @witemshelf.item24_id, item25_id: @witemshelf.item25_id, item26_id: @witemshelf.item26_id, item27_id: @witemshelf.item27_id, item28_id: @witemshelf.item28_id, item29_id: @witemshelf.item29_id, item2_id: @witemshelf.item2_id, item30_id: @witemshelf.item30_id, item3_id: @witemshelf.item3_id, item4_id: @witemshelf.item4_id, item5_id: @witemshelf.item5_id, item6_id: @witemshelf.item6_id, item7_id: @witemshelf.item7_id, item8_id: @witemshelf.item8_id, item9_id: @witemshelf.item9_id, name: @witemshelf.name, qty1: @witemshelf.qty1, qty10: @witemshelf.qty10, qty11: @witemshelf.qty11, qty12: @witemshelf.qty12, qty13: @witemshelf.qty13, qty14: @witemshelf.qty14, qty15: @witemshelf.qty15, qty16: @witemshelf.qty16, qty17: @witemshelf.qty17, qty18: @witemshelf.qty18, qty19: @witemshelf.qty19, qty2: @witemshelf.qty2, qty20: @witemshelf.qty20, qty21: @witemshelf.qty21, qty22: @witemshelf.qty22, qty23: @witemshelf.qty23, qty24: @witemshelf.qty24, qty25: @witemshelf.qty25, qty26: @witemshelf.qty26, qty27: @witemshelf.qty27, qty28: @witemshelf.qty28, qty29: @witemshelf.qty29, qty3: @witemshelf.qty3, qty30: @witemshelf.qty30, qty4: @witemshelf.qty4, qty5: @witemshelf.qty5, qty6: @witemshelf.qty6, qty7: @witemshelf.qty7, qty8: @witemshelf.qty8, qty9: @witemshelf.qty9, tax1: @witemshelf.tax1, tax10: @witemshelf.tax10, tax11: @witemshelf.tax11, tax12: @witemshelf.tax12, tax13: @witemshelf.tax13, tax14: @witemshelf.tax14, tax15: @witemshelf.tax15, tax16: @witemshelf.tax16, tax17: @witemshelf.tax17, tax18: @witemshelf.tax18, tax19: @witemshelf.tax19, tax2: @witemshelf.tax2, tax20: @witemshelf.tax20, tax21: @witemshelf.tax21, tax22: @witemshelf.tax22, tax23: @witemshelf.tax23, tax24: @witemshelf.tax24, tax25: @witemshelf.tax25, tax26: @witemshelf.tax26, tax27: @witemshelf.tax27, tax28: @witemshelf.tax28, tax29: @witemshelf.tax29, tax3: @witemshelf.tax3, tax30: @witemshelf.tax30, tax4: @witemshelf.tax4, tax5: @witemshelf.tax5, tax6: @witemshelf.tax6, tax7: @witemshelf.tax7, tax8: @witemshelf.tax8, tax9: @witemshelf.tax9, warehouse_id: @witemshelf.warehouse_id } }
    end

    assert_redirected_to witemshelf_url(Witemshelf.last)
  end

  test "should show witemshelf" do
    get witemshelf_url(@witemshelf)
    assert_response :success
  end

  test "should get edit" do
    get edit_witemshelf_url(@witemshelf)
    assert_response :success
  end

  test "should update witemshelf" do
    patch witemshelf_url(@witemshelf), params: { witemshelf: { item10_id: @witemshelf.item10_id, item11_id: @witemshelf.item11_id, item12_id: @witemshelf.item12_id, item13_id: @witemshelf.item13_id, item14_id: @witemshelf.item14_id, item15_id: @witemshelf.item15_id, item16_id: @witemshelf.item16_id, item17_id: @witemshelf.item17_id, item18_id: @witemshelf.item18_id, item19_id: @witemshelf.item19_id, item1_id: @witemshelf.item1_id, item20_id: @witemshelf.item20_id, item21_id: @witemshelf.item21_id, item22_id: @witemshelf.item22_id, item23_id: @witemshelf.item23_id, item24_id: @witemshelf.item24_id, item25_id: @witemshelf.item25_id, item26_id: @witemshelf.item26_id, item27_id: @witemshelf.item27_id, item28_id: @witemshelf.item28_id, item29_id: @witemshelf.item29_id, item2_id: @witemshelf.item2_id, item30_id: @witemshelf.item30_id, item3_id: @witemshelf.item3_id, item4_id: @witemshelf.item4_id, item5_id: @witemshelf.item5_id, item6_id: @witemshelf.item6_id, item7_id: @witemshelf.item7_id, item8_id: @witemshelf.item8_id, item9_id: @witemshelf.item9_id, name: @witemshelf.name, qty1: @witemshelf.qty1, qty10: @witemshelf.qty10, qty11: @witemshelf.qty11, qty12: @witemshelf.qty12, qty13: @witemshelf.qty13, qty14: @witemshelf.qty14, qty15: @witemshelf.qty15, qty16: @witemshelf.qty16, qty17: @witemshelf.qty17, qty18: @witemshelf.qty18, qty19: @witemshelf.qty19, qty2: @witemshelf.qty2, qty20: @witemshelf.qty20, qty21: @witemshelf.qty21, qty22: @witemshelf.qty22, qty23: @witemshelf.qty23, qty24: @witemshelf.qty24, qty25: @witemshelf.qty25, qty26: @witemshelf.qty26, qty27: @witemshelf.qty27, qty28: @witemshelf.qty28, qty29: @witemshelf.qty29, qty3: @witemshelf.qty3, qty30: @witemshelf.qty30, qty4: @witemshelf.qty4, qty5: @witemshelf.qty5, qty6: @witemshelf.qty6, qty7: @witemshelf.qty7, qty8: @witemshelf.qty8, qty9: @witemshelf.qty9, tax1: @witemshelf.tax1, tax10: @witemshelf.tax10, tax11: @witemshelf.tax11, tax12: @witemshelf.tax12, tax13: @witemshelf.tax13, tax14: @witemshelf.tax14, tax15: @witemshelf.tax15, tax16: @witemshelf.tax16, tax17: @witemshelf.tax17, tax18: @witemshelf.tax18, tax19: @witemshelf.tax19, tax2: @witemshelf.tax2, tax20: @witemshelf.tax20, tax21: @witemshelf.tax21, tax22: @witemshelf.tax22, tax23: @witemshelf.tax23, tax24: @witemshelf.tax24, tax25: @witemshelf.tax25, tax26: @witemshelf.tax26, tax27: @witemshelf.tax27, tax28: @witemshelf.tax28, tax29: @witemshelf.tax29, tax3: @witemshelf.tax3, tax30: @witemshelf.tax30, tax4: @witemshelf.tax4, tax5: @witemshelf.tax5, tax6: @witemshelf.tax6, tax7: @witemshelf.tax7, tax8: @witemshelf.tax8, tax9: @witemshelf.tax9, warehouse_id: @witemshelf.warehouse_id } }
    assert_redirected_to witemshelf_url(@witemshelf)
  end

  test "should destroy witemshelf" do
    assert_difference('Witemshelf.count', -1) do
      delete witemshelf_url(@witemshelf)
    end

    assert_redirected_to witemshelves_url
  end
end
