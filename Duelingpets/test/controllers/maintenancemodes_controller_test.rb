require 'test_helper'

class MaintenancemodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maintenancemode = maintenancemodes(:one)
  end

  test "should get index" do
    get maintenancemodes_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenancemode_url
    assert_response :success
  end

  test "should create maintenancemode" do
    assert_difference('Maintenancemode.count') do
      post maintenancemodes_url, params: { maintenancemode: { created_on: @maintenancemode.created_on, maintenance_on: @maintenancemode.maintenance_on, name: @maintenancemode.name } }
    end

    assert_redirected_to maintenancemode_url(Maintenancemode.last)
  end

  test "should show maintenancemode" do
    get maintenancemode_url(@maintenancemode)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenancemode_url(@maintenancemode)
    assert_response :success
  end

  test "should update maintenancemode" do
    patch maintenancemode_url(@maintenancemode), params: { maintenancemode: { created_on: @maintenancemode.created_on, maintenance_on: @maintenancemode.maintenance_on, name: @maintenancemode.name } }
    assert_redirected_to maintenancemode_url(@maintenancemode)
  end

  test "should destroy maintenancemode" do
    assert_difference('Maintenancemode.count', -1) do
      delete maintenancemode_url(@maintenancemode)
    end

    assert_redirected_to maintenancemodes_url
  end
end
