require 'test_helper'

class WpetdensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wpetden = wpetdens(:one)
  end

  test "should get index" do
    get wpetdens_url
    assert_response :success
  end

  test "should get new" do
    get new_wpetden_url
    assert_response :success
  end

  test "should create wpetden" do
    assert_difference('Wpetden.count') do
      post wpetdens_url, params: { wpetden: { creature10_id: @wpetden.creature10_id, creature11_id: @wpetden.creature11_id, creature12_id: @wpetden.creature12_id, creature13_id: @wpetden.creature13_id, creature14_id: @wpetden.creature14_id, creature15_id: @wpetden.creature15_id, creature16_id: @wpetden.creature16_id, creature1_id: @wpetden.creature1_id, creature2_id: @wpetden.creature2_id, creature3_id: @wpetden.creature3_id, creature4_id: @wpetden.creature4_id, creature5_id: @wpetden.creature5_id, creature6_id: @wpetden.creature6_id, creature7_id: @wpetden.creature7_id, creature8_id: @wpetden.creature8_id, creature9_id: @wpetden.creature9_id, name: @wpetden.name, qty1: @wpetden.qty1, qty10: @wpetden.qty10, qty11: @wpetden.qty11, qty12: @wpetden.qty12, qty13: @wpetden.qty13, qty14: @wpetden.qty14, qty15: @wpetden.qty15, qty16: @wpetden.qty16, qty2: @wpetden.qty2, qty3: @wpetden.qty3, qty4: @wpetden.qty4, qty5: @wpetden.qty5, qty6: @wpetden.qty6, qty7: @wpetden.qty7, qty8: @wpetden.qty8, qty9: @wpetden.qty9, tax1: @wpetden.tax1, tax10: @wpetden.tax10, tax11: @wpetden.tax11, tax12: @wpetden.tax12, tax13: @wpetden.tax13, tax14: @wpetden.tax14, tax15: @wpetden.tax15, tax16: @wpetden.tax16, tax2: @wpetden.tax2, tax3: @wpetden.tax3, tax4: @wpetden.tax4, tax5: @wpetden.tax5, tax6: @wpetden.tax6, tax7: @wpetden.tax7, tax8: @wpetden.tax8, tax9: @wpetden.tax9, warehouse_id: @wpetden.warehouse_id } }
    end

    assert_redirected_to wpetden_url(Wpetden.last)
  end

  test "should show wpetden" do
    get wpetden_url(@wpetden)
    assert_response :success
  end

  test "should get edit" do
    get edit_wpetden_url(@wpetden)
    assert_response :success
  end

  test "should update wpetden" do
    patch wpetden_url(@wpetden), params: { wpetden: { creature10_id: @wpetden.creature10_id, creature11_id: @wpetden.creature11_id, creature12_id: @wpetden.creature12_id, creature13_id: @wpetden.creature13_id, creature14_id: @wpetden.creature14_id, creature15_id: @wpetden.creature15_id, creature16_id: @wpetden.creature16_id, creature1_id: @wpetden.creature1_id, creature2_id: @wpetden.creature2_id, creature3_id: @wpetden.creature3_id, creature4_id: @wpetden.creature4_id, creature5_id: @wpetden.creature5_id, creature6_id: @wpetden.creature6_id, creature7_id: @wpetden.creature7_id, creature8_id: @wpetden.creature8_id, creature9_id: @wpetden.creature9_id, name: @wpetden.name, qty1: @wpetden.qty1, qty10: @wpetden.qty10, qty11: @wpetden.qty11, qty12: @wpetden.qty12, qty13: @wpetden.qty13, qty14: @wpetden.qty14, qty15: @wpetden.qty15, qty16: @wpetden.qty16, qty2: @wpetden.qty2, qty3: @wpetden.qty3, qty4: @wpetden.qty4, qty5: @wpetden.qty5, qty6: @wpetden.qty6, qty7: @wpetden.qty7, qty8: @wpetden.qty8, qty9: @wpetden.qty9, tax1: @wpetden.tax1, tax10: @wpetden.tax10, tax11: @wpetden.tax11, tax12: @wpetden.tax12, tax13: @wpetden.tax13, tax14: @wpetden.tax14, tax15: @wpetden.tax15, tax16: @wpetden.tax16, tax2: @wpetden.tax2, tax3: @wpetden.tax3, tax4: @wpetden.tax4, tax5: @wpetden.tax5, tax6: @wpetden.tax6, tax7: @wpetden.tax7, tax8: @wpetden.tax8, tax9: @wpetden.tax9, warehouse_id: @wpetden.warehouse_id } }
    assert_redirected_to wpetden_url(@wpetden)
  end

  test "should destroy wpetden" do
    assert_difference('Wpetden.count', -1) do
      delete wpetden_url(@wpetden)
    end

    assert_redirected_to wpetdens_url
  end
end
