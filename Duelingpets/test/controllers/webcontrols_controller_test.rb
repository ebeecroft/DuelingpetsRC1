require 'test_helper'

class WebcontrolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @webcontrol = webcontrols(:one)
  end

  test "should get index" do
    get webcontrols_url
    assert_response :success
  end

  test "should get new" do
    get new_webcontrol_url
    assert_response :success
  end

  test "should create webcontrol" do
    assert_difference('Webcontrol.count') do
      post webcontrols_url, params: { webcontrol: { banner: @webcontrol.banner, betamp3: @webcontrol.betamp3, betaogg: @webcontrol.betaogg, created_on: @webcontrol.created_on, creationmp3: @webcontrol.creationmp3, creationogg: @webcontrol.creationogg, criticalmp3: @webcontrol.criticalmp3, criticalogg: @webcontrol.criticalogg, daycolor_id: @webcontrol.daycolor_id, favicon: @webcontrol.favicon, gate_open: @webcontrol.gate_open, grandmp3: @webcontrol.grandmp3, grandogg: @webcontrol.grandogg, maintenancemp3: @webcontrol.maintenancemp3, maintenanceogg: @webcontrol.maintenanceogg, mascot: @webcontrol.mascot, mp3: @webcontrol.mp3, nightcolor_id: @webcontrol.nightcolor_id, ogg: @webcontrol.ogg } }
    end

    assert_redirected_to webcontrol_url(Webcontrol.last)
  end

  test "should show webcontrol" do
    get webcontrol_url(@webcontrol)
    assert_response :success
  end

  test "should get edit" do
    get edit_webcontrol_url(@webcontrol)
    assert_response :success
  end

  test "should update webcontrol" do
    patch webcontrol_url(@webcontrol), params: { webcontrol: { banner: @webcontrol.banner, betamp3: @webcontrol.betamp3, betaogg: @webcontrol.betaogg, created_on: @webcontrol.created_on, creationmp3: @webcontrol.creationmp3, creationogg: @webcontrol.creationogg, criticalmp3: @webcontrol.criticalmp3, criticalogg: @webcontrol.criticalogg, daycolor_id: @webcontrol.daycolor_id, favicon: @webcontrol.favicon, gate_open: @webcontrol.gate_open, grandmp3: @webcontrol.grandmp3, grandogg: @webcontrol.grandogg, maintenancemp3: @webcontrol.maintenancemp3, maintenanceogg: @webcontrol.maintenanceogg, mascot: @webcontrol.mascot, mp3: @webcontrol.mp3, nightcolor_id: @webcontrol.nightcolor_id, ogg: @webcontrol.ogg } }
    assert_redirected_to webcontrol_url(@webcontrol)
  end

  test "should destroy webcontrol" do
    assert_difference('Webcontrol.count', -1) do
      delete webcontrol_url(@webcontrol)
    end

    assert_redirected_to webcontrols_url
  end
end
