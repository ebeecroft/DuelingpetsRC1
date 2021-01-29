require 'test_helper'

class PouchslotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pouchslot = pouchslots(:one)
  end

  test "should get index" do
    get pouchslots_url
    assert_response :success
  end

  test "should get new" do
    get new_pouchslot_url
    assert_response :success
  end

  test "should create pouchslot" do
    assert_difference('Pouchslot.count') do
      post pouchslots_url, params: { pouchslot: { free1: @pouchslot.free1, free10: @pouchslot.free10, free11: @pouchslot.free11, free12: @pouchslot.free12, free13: @pouchslot.free13, free14: @pouchslot.free14, free15: @pouchslot.free15, free16: @pouchslot.free16, free17: @pouchslot.free17, free18: @pouchslot.free18, free19: @pouchslot.free19, free2: @pouchslot.free2, free20: @pouchslot.free20, free21: @pouchslot.free21, free22: @pouchslot.free22, free23: @pouchslot.free23, free24: @pouchslot.free24, free25: @pouchslot.free25, free26: @pouchslot.free26, free27: @pouchslot.free27, free28: @pouchslot.free28, free29: @pouchslot.free29, free3: @pouchslot.free3, free30: @pouchslot.free30, free31: @pouchslot.free31, free32: @pouchslot.free32, free33: @pouchslot.free33, free34: @pouchslot.free34, free35: @pouchslot.free35, free36: @pouchslot.free36, free37: @pouchslot.free37, free38: @pouchslot.free38, free39: @pouchslot.free39, free4: @pouchslot.free4, free40: @pouchslot.free40, free41: @pouchslot.free41, free42: @pouchslot.free42, free5: @pouchslot.free5, free6: @pouchslot.free6, free7: @pouchslot.free7, free8: @pouchslot.free8, free9: @pouchslot.free9, member1: @pouchslot.member1, member10: @pouchslot.member10, member11: @pouchslot.member11, member12: @pouchslot.member12, member13: @pouchslot.member13, member14: @pouchslot.member14, member15: @pouchslot.member15, member16: @pouchslot.member16, member17: @pouchslot.member17, member18: @pouchslot.member18, member19: @pouchslot.member19, member2: @pouchslot.member2, member20: @pouchslot.member20, member21: @pouchslot.member21, member22: @pouchslot.member22, member23: @pouchslot.member23, member24: @pouchslot.member24, member25: @pouchslot.member25, member26: @pouchslot.member26, member27: @pouchslot.member27, member28: @pouchslot.member28, member29: @pouchslot.member29, member3: @pouchslot.member3, member30: @pouchslot.member30, member31: @pouchslot.member31, member32: @pouchslot.member32, member33: @pouchslot.member33, member34: @pouchslot.member34, member35: @pouchslot.member35, member36: @pouchslot.member36, member37: @pouchslot.member37, member38: @pouchslot.member38, member39: @pouchslot.member39, member4: @pouchslot.member4, member40: @pouchslot.member40, member41: @pouchslot.member41, member42: @pouchslot.member42, member5: @pouchslot.member5, member6: @pouchslot.member6, member7: @pouchslot.member7, member8: @pouchslot.member8, member9: @pouchslot.member9, pouch_id: @pouchslot.pouch_id, pouchtype10_id: @pouchslot.pouchtype10_id, pouchtype11_id: @pouchslot.pouchtype11_id, pouchtype12_id: @pouchslot.pouchtype12_id, pouchtype13_id: @pouchslot.pouchtype13_id, pouchtype14_id: @pouchslot.pouchtype14_id, pouchtype15_id: @pouchslot.pouchtype15_id, pouchtype16_id: @pouchslot.pouchtype16_id, pouchtype17_id: @pouchslot.pouchtype17_id, pouchtype18_id: @pouchslot.pouchtype18_id, pouchtype19_id: @pouchslot.pouchtype19_id, pouchtype1_id: @pouchslot.pouchtype1_id, pouchtype20_id: @pouchslot.pouchtype20_id, pouchtype21_id: @pouchslot.pouchtype21_id, pouchtype22_id: @pouchslot.pouchtype22_id, pouchtype23_id: @pouchslot.pouchtype23_id, pouchtype24_id: @pouchslot.pouchtype24_id, pouchtype25_id: @pouchslot.pouchtype25_id, pouchtype26_id: @pouchslot.pouchtype26_id, pouchtype27_id: @pouchslot.pouchtype27_id, pouchtype28_id: @pouchslot.pouchtype28_id, pouchtype29_id: @pouchslot.pouchtype29_id, pouchtype2_id: @pouchslot.pouchtype2_id, pouchtype30_id: @pouchslot.pouchtype30_id, pouchtype31_id: @pouchslot.pouchtype31_id, pouchtype32_id: @pouchslot.pouchtype32_id, pouchtype33_id: @pouchslot.pouchtype33_id, pouchtype34_id: @pouchslot.pouchtype34_id, pouchtype35_id: @pouchslot.pouchtype35_id, pouchtype36_id: @pouchslot.pouchtype36_id, pouchtype37_id: @pouchslot.pouchtype37_id, pouchtype38_id: @pouchslot.pouchtype38_id, pouchtype39_id: @pouchslot.pouchtype39_id, pouchtype3_id: @pouchslot.pouchtype3_id, pouchtype40_id: @pouchslot.pouchtype40_id, pouchtype41_id: @pouchslot.pouchtype41_id, pouchtype42_id: @pouchslot.pouchtype42_id, pouchtype4_id: @pouchslot.pouchtype4_id, pouchtype5_id: @pouchslot.pouchtype5_id, pouchtype6_id: @pouchslot.pouchtype6_id, pouchtype7_id: @pouchslot.pouchtype7_id, pouchtype8_id: @pouchslot.pouchtype8_id, pouchtype9_id: @pouchslot.pouchtype9_id } }
    end

    assert_redirected_to pouchslot_url(Pouchslot.last)
  end

  test "should show pouchslot" do
    get pouchslot_url(@pouchslot)
    assert_response :success
  end

  test "should get edit" do
    get edit_pouchslot_url(@pouchslot)
    assert_response :success
  end

  test "should update pouchslot" do
    patch pouchslot_url(@pouchslot), params: { pouchslot: { free1: @pouchslot.free1, free10: @pouchslot.free10, free11: @pouchslot.free11, free12: @pouchslot.free12, free13: @pouchslot.free13, free14: @pouchslot.free14, free15: @pouchslot.free15, free16: @pouchslot.free16, free17: @pouchslot.free17, free18: @pouchslot.free18, free19: @pouchslot.free19, free2: @pouchslot.free2, free20: @pouchslot.free20, free21: @pouchslot.free21, free22: @pouchslot.free22, free23: @pouchslot.free23, free24: @pouchslot.free24, free25: @pouchslot.free25, free26: @pouchslot.free26, free27: @pouchslot.free27, free28: @pouchslot.free28, free29: @pouchslot.free29, free3: @pouchslot.free3, free30: @pouchslot.free30, free31: @pouchslot.free31, free32: @pouchslot.free32, free33: @pouchslot.free33, free34: @pouchslot.free34, free35: @pouchslot.free35, free36: @pouchslot.free36, free37: @pouchslot.free37, free38: @pouchslot.free38, free39: @pouchslot.free39, free4: @pouchslot.free4, free40: @pouchslot.free40, free41: @pouchslot.free41, free42: @pouchslot.free42, free5: @pouchslot.free5, free6: @pouchslot.free6, free7: @pouchslot.free7, free8: @pouchslot.free8, free9: @pouchslot.free9, member1: @pouchslot.member1, member10: @pouchslot.member10, member11: @pouchslot.member11, member12: @pouchslot.member12, member13: @pouchslot.member13, member14: @pouchslot.member14, member15: @pouchslot.member15, member16: @pouchslot.member16, member17: @pouchslot.member17, member18: @pouchslot.member18, member19: @pouchslot.member19, member2: @pouchslot.member2, member20: @pouchslot.member20, member21: @pouchslot.member21, member22: @pouchslot.member22, member23: @pouchslot.member23, member24: @pouchslot.member24, member25: @pouchslot.member25, member26: @pouchslot.member26, member27: @pouchslot.member27, member28: @pouchslot.member28, member29: @pouchslot.member29, member3: @pouchslot.member3, member30: @pouchslot.member30, member31: @pouchslot.member31, member32: @pouchslot.member32, member33: @pouchslot.member33, member34: @pouchslot.member34, member35: @pouchslot.member35, member36: @pouchslot.member36, member37: @pouchslot.member37, member38: @pouchslot.member38, member39: @pouchslot.member39, member4: @pouchslot.member4, member40: @pouchslot.member40, member41: @pouchslot.member41, member42: @pouchslot.member42, member5: @pouchslot.member5, member6: @pouchslot.member6, member7: @pouchslot.member7, member8: @pouchslot.member8, member9: @pouchslot.member9, pouch_id: @pouchslot.pouch_id, pouchtype10_id: @pouchslot.pouchtype10_id, pouchtype11_id: @pouchslot.pouchtype11_id, pouchtype12_id: @pouchslot.pouchtype12_id, pouchtype13_id: @pouchslot.pouchtype13_id, pouchtype14_id: @pouchslot.pouchtype14_id, pouchtype15_id: @pouchslot.pouchtype15_id, pouchtype16_id: @pouchslot.pouchtype16_id, pouchtype17_id: @pouchslot.pouchtype17_id, pouchtype18_id: @pouchslot.pouchtype18_id, pouchtype19_id: @pouchslot.pouchtype19_id, pouchtype1_id: @pouchslot.pouchtype1_id, pouchtype20_id: @pouchslot.pouchtype20_id, pouchtype21_id: @pouchslot.pouchtype21_id, pouchtype22_id: @pouchslot.pouchtype22_id, pouchtype23_id: @pouchslot.pouchtype23_id, pouchtype24_id: @pouchslot.pouchtype24_id, pouchtype25_id: @pouchslot.pouchtype25_id, pouchtype26_id: @pouchslot.pouchtype26_id, pouchtype27_id: @pouchslot.pouchtype27_id, pouchtype28_id: @pouchslot.pouchtype28_id, pouchtype29_id: @pouchslot.pouchtype29_id, pouchtype2_id: @pouchslot.pouchtype2_id, pouchtype30_id: @pouchslot.pouchtype30_id, pouchtype31_id: @pouchslot.pouchtype31_id, pouchtype32_id: @pouchslot.pouchtype32_id, pouchtype33_id: @pouchslot.pouchtype33_id, pouchtype34_id: @pouchslot.pouchtype34_id, pouchtype35_id: @pouchslot.pouchtype35_id, pouchtype36_id: @pouchslot.pouchtype36_id, pouchtype37_id: @pouchslot.pouchtype37_id, pouchtype38_id: @pouchslot.pouchtype38_id, pouchtype39_id: @pouchslot.pouchtype39_id, pouchtype3_id: @pouchslot.pouchtype3_id, pouchtype40_id: @pouchslot.pouchtype40_id, pouchtype41_id: @pouchslot.pouchtype41_id, pouchtype42_id: @pouchslot.pouchtype42_id, pouchtype4_id: @pouchslot.pouchtype4_id, pouchtype5_id: @pouchslot.pouchtype5_id, pouchtype6_id: @pouchslot.pouchtype6_id, pouchtype7_id: @pouchslot.pouchtype7_id, pouchtype8_id: @pouchslot.pouchtype8_id, pouchtype9_id: @pouchslot.pouchtype9_id } }
    assert_redirected_to pouchslot_url(@pouchslot)
  end

  test "should destroy pouchslot" do
    assert_difference('Pouchslot.count', -1) do
      delete pouchslot_url(@pouchslot)
    end

    assert_redirected_to pouchslots_url
  end
end
