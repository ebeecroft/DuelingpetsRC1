require 'test_helper'

class InventoryslotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventoryslot = inventoryslots(:one)
  end

  test "should get index" do
    get inventoryslots_url
    assert_response :success
  end

  test "should get new" do
    get new_inventoryslot_url
    assert_response :success
  end

  test "should create inventoryslot" do
    assert_difference('Inventoryslot.count') do
      post inventoryslots_url, params: { inventoryslot: { inventory_id: @inventoryslot.inventory_id, mainitem1_id: @inventoryslot.mainitem1_id, mainitem2_id: @inventoryslot.mainitem2_id, mainitem3_id: @inventoryslot.mainitem3_id, mainitem4_id: @inventoryslot.mainitem4_id, mcurdur1: @inventoryslot.mcurdur1, mcurdur2: @inventoryslot.mcurdur2, mcurdur3: @inventoryslot.mcurdur3, mcurdur4: @inventoryslot.mcurdur4, mitemcost1: @inventoryslot.mitemcost1, mitemcost2: @inventoryslot.mitemcost2, mitemcost3: @inventoryslot.mitemcost3, mitemcost4: @inventoryslot.mitemcost4, mmaxdur1: @inventoryslot.mmaxdur1, mmaxdur2: @inventoryslot.mmaxdur2, mmaxdur3: @inventoryslot.mmaxdur3, mmaxdur4: @inventoryslot.mmaxdur4, mmindur1: @inventoryslot.mmindur1, mmindur2: @inventoryslot.mmindur2, mmindur3: @inventoryslot.mmindur3, mmindur4: @inventoryslot.mmindur4, mqty1: @inventoryslot.mqty1, mqty2: @inventoryslot.mqty2, mqty3: @inventoryslot.mqty3, mqty4: @inventoryslot.mqty4, scurdur1a: @inventoryslot.scurdur1a, scurdur2a: @inventoryslot.scurdur2a, scurdur3a: @inventoryslot.scurdur3a, scurdur4a: @inventoryslot.scurdur4a, sitemcost1a: @inventoryslot.sitemcost1a, sitemcost2a: @inventoryslot.sitemcost2a, sitemcost3a: @inventoryslot.sitemcost3a, sitemcost4a: @inventoryslot.sitemcost4a, smaxdur1a: @inventoryslot.smaxdur1a, smaxdur2a: @inventoryslot.smaxdur2a, smaxdur3a: @inventoryslot.smaxdur3a, smaxdur4a: @inventoryslot.smaxdur4a, smindur1a: @inventoryslot.smindur1a, smindur2a: @inventoryslot.smindur2a, smindur3a: @inventoryslot.smindur3a, smindur4a: @inventoryslot.smindur4a, sqty1a: @inventoryslot.sqty1a, sqty2a: @inventoryslot.sqty2a, sqty3a: @inventoryslot.sqty3a, sqty4a: @inventoryslot.sqty4a, subitem1a_id: @inventoryslot.subitem1a_id, subitem2a_id: @inventoryslot.subitem2a_id, subitem3a_id: @inventoryslot.subitem3a_id, subitem4a_id: @inventoryslot.subitem4a_id } }
    end

    assert_redirected_to inventoryslot_url(Inventoryslot.last)
  end

  test "should show inventoryslot" do
    get inventoryslot_url(@inventoryslot)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventoryslot_url(@inventoryslot)
    assert_response :success
  end

  test "should update inventoryslot" do
    patch inventoryslot_url(@inventoryslot), params: { inventoryslot: { inventory_id: @inventoryslot.inventory_id, mainitem1_id: @inventoryslot.mainitem1_id, mainitem2_id: @inventoryslot.mainitem2_id, mainitem3_id: @inventoryslot.mainitem3_id, mainitem4_id: @inventoryslot.mainitem4_id, mcurdur1: @inventoryslot.mcurdur1, mcurdur2: @inventoryslot.mcurdur2, mcurdur3: @inventoryslot.mcurdur3, mcurdur4: @inventoryslot.mcurdur4, mitemcost1: @inventoryslot.mitemcost1, mitemcost2: @inventoryslot.mitemcost2, mitemcost3: @inventoryslot.mitemcost3, mitemcost4: @inventoryslot.mitemcost4, mmaxdur1: @inventoryslot.mmaxdur1, mmaxdur2: @inventoryslot.mmaxdur2, mmaxdur3: @inventoryslot.mmaxdur3, mmaxdur4: @inventoryslot.mmaxdur4, mmindur1: @inventoryslot.mmindur1, mmindur2: @inventoryslot.mmindur2, mmindur3: @inventoryslot.mmindur3, mmindur4: @inventoryslot.mmindur4, mqty1: @inventoryslot.mqty1, mqty2: @inventoryslot.mqty2, mqty3: @inventoryslot.mqty3, mqty4: @inventoryslot.mqty4, scurdur1a: @inventoryslot.scurdur1a, scurdur2a: @inventoryslot.scurdur2a, scurdur3a: @inventoryslot.scurdur3a, scurdur4a: @inventoryslot.scurdur4a, sitemcost1a: @inventoryslot.sitemcost1a, sitemcost2a: @inventoryslot.sitemcost2a, sitemcost3a: @inventoryslot.sitemcost3a, sitemcost4a: @inventoryslot.sitemcost4a, smaxdur1a: @inventoryslot.smaxdur1a, smaxdur2a: @inventoryslot.smaxdur2a, smaxdur3a: @inventoryslot.smaxdur3a, smaxdur4a: @inventoryslot.smaxdur4a, smindur1a: @inventoryslot.smindur1a, smindur2a: @inventoryslot.smindur2a, smindur3a: @inventoryslot.smindur3a, smindur4a: @inventoryslot.smindur4a, sqty1a: @inventoryslot.sqty1a, sqty2a: @inventoryslot.sqty2a, sqty3a: @inventoryslot.sqty3a, sqty4a: @inventoryslot.sqty4a, subitem1a_id: @inventoryslot.subitem1a_id, subitem2a_id: @inventoryslot.subitem2a_id, subitem3a_id: @inventoryslot.subitem3a_id, subitem4a_id: @inventoryslot.subitem4a_id } }
    assert_redirected_to inventoryslot_url(@inventoryslot)
  end

  test "should destroy inventoryslot" do
    assert_difference('Inventoryslot.count', -1) do
      delete inventoryslot_url(@inventoryslot)
    end

    assert_redirected_to inventoryslots_url
  end
end
