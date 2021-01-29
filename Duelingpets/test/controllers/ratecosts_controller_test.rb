require 'test_helper'

class RatecostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ratecost = ratecosts(:one)
  end

  test "should get index" do
    get ratecosts_url
    assert_response :success
  end

  test "should get new" do
    get new_ratecost_url
    assert_response :success
  end

  test "should create ratecost" do
    assert_difference('Ratecost.count') do
      post ratecosts_url, params: { ratecost: { amount: @ratecost.amount, baserate_id: @ratecost.baserate_id, created_on: @ratecost.created_on, dragonhoard_id: @ratecost.dragonhoard_id, econtype: @ratecost.econtype, name: @ratecost.name, updated_on: @ratecost.updated_on } }
    end

    assert_redirected_to ratecost_url(Ratecost.last)
  end

  test "should show ratecost" do
    get ratecost_url(@ratecost)
    assert_response :success
  end

  test "should get edit" do
    get edit_ratecost_url(@ratecost)
    assert_response :success
  end

  test "should update ratecost" do
    patch ratecost_url(@ratecost), params: { ratecost: { amount: @ratecost.amount, baserate_id: @ratecost.baserate_id, created_on: @ratecost.created_on, dragonhoard_id: @ratecost.dragonhoard_id, econtype: @ratecost.econtype, name: @ratecost.name, updated_on: @ratecost.updated_on } }
    assert_redirected_to ratecost_url(@ratecost)
  end

  test "should destroy ratecost" do
    assert_difference('Ratecost.count', -1) do
      delete ratecost_url(@ratecost)
    end

    assert_redirected_to ratecosts_url
  end
end
