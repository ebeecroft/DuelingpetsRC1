require 'test_helper'

class FieldcostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fieldcost = fieldcosts(:one)
  end

  test "should get index" do
    get fieldcosts_url
    assert_response :success
  end

  test "should get new" do
    get new_fieldcost_url
    assert_response :success
  end

  test "should create fieldcost" do
    assert_difference('Fieldcost.count') do
      post fieldcosts_url, params: { fieldcost: { amount: @fieldcost.amount, baseinc_id: @fieldcost.baseinc_id, created_on: @fieldcost.created_on, dragonhoard_id: @fieldcost.dragonhoard_id, econtype: @fieldcost.econtype, name: @fieldcost.name, updated_on: @fieldcost.updated_on } }
    end

    assert_redirected_to fieldcost_url(Fieldcost.last)
  end

  test "should show fieldcost" do
    get fieldcost_url(@fieldcost)
    assert_response :success
  end

  test "should get edit" do
    get edit_fieldcost_url(@fieldcost)
    assert_response :success
  end

  test "should update fieldcost" do
    patch fieldcost_url(@fieldcost), params: { fieldcost: { amount: @fieldcost.amount, baseinc_id: @fieldcost.baseinc_id, created_on: @fieldcost.created_on, dragonhoard_id: @fieldcost.dragonhoard_id, econtype: @fieldcost.econtype, name: @fieldcost.name, updated_on: @fieldcost.updated_on } }
    assert_redirected_to fieldcost_url(@fieldcost)
  end

  test "should destroy fieldcost" do
    assert_difference('Fieldcost.count', -1) do
      delete fieldcost_url(@fieldcost)
    end

    assert_redirected_to fieldcosts_url
  end
end
