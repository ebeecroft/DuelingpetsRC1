require 'test_helper'

class EquipslotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipslot = equipslots(:one)
  end

  test "should get index" do
    get equipslots_url
    assert_response :success
  end

  test "should get new" do
    get new_equipslot_url
    assert_response :success
  end

  test "should create equipslot" do
    assert_difference('Equipslot.count') do
      post equipslots_url, params: { equipslot: { activeslot: @equipslot.activeslot, curdur1: @equipslot.curdur1, curdur2: @equipslot.curdur2, curdur3: @equipslot.curdur3, curdur4: @equipslot.curdur4, curdur5: @equipslot.curdur5, curdur6: @equipslot.curdur6, curdur7: @equipslot.curdur7, curdur8: @equipslot.curdur8, equip_id: @equipslot.equip_id, item1_id: @equipslot.item1_id, item2_id: @equipslot.item2_id, item3_id: @equipslot.item3_id, item4_id: @equipslot.item4_id, item5_id: @equipslot.item5_id, item6_id: @equipslot.item6_id, item7_id: @equipslot.item7_id, item8_id: @equipslot.item8_id, name: @equipslot.name, startdur1: @equipslot.startdur1, startdur2: @equipslot.startdur2, startdur3: @equipslot.startdur3, startdur4: @equipslot.startdur4, startdur5: @equipslot.startdur5, startdur6: @equipslot.startdur6, startdur7: @equipslot.startdur7, startdur8: @equipslot.startdur8 } }
    end

    assert_redirected_to equipslot_url(Equipslot.last)
  end

  test "should show equipslot" do
    get equipslot_url(@equipslot)
    assert_response :success
  end

  test "should get edit" do
    get edit_equipslot_url(@equipslot)
    assert_response :success
  end

  test "should update equipslot" do
    patch equipslot_url(@equipslot), params: { equipslot: { activeslot: @equipslot.activeslot, curdur1: @equipslot.curdur1, curdur2: @equipslot.curdur2, curdur3: @equipslot.curdur3, curdur4: @equipslot.curdur4, curdur5: @equipslot.curdur5, curdur6: @equipslot.curdur6, curdur7: @equipslot.curdur7, curdur8: @equipslot.curdur8, equip_id: @equipslot.equip_id, item1_id: @equipslot.item1_id, item2_id: @equipslot.item2_id, item3_id: @equipslot.item3_id, item4_id: @equipslot.item4_id, item5_id: @equipslot.item5_id, item6_id: @equipslot.item6_id, item7_id: @equipslot.item7_id, item8_id: @equipslot.item8_id, name: @equipslot.name, startdur1: @equipslot.startdur1, startdur2: @equipslot.startdur2, startdur3: @equipslot.startdur3, startdur4: @equipslot.startdur4, startdur5: @equipslot.startdur5, startdur6: @equipslot.startdur6, startdur7: @equipslot.startdur7, startdur8: @equipslot.startdur8 } }
    assert_redirected_to equipslot_url(@equipslot)
  end

  test "should destroy equipslot" do
    assert_difference('Equipslot.count', -1) do
      delete equipslot_url(@equipslot)
    end

    assert_redirected_to equipslots_url
  end
end
