require 'test_helper'

class ElementchartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @elementchart = elementcharts(:one)
  end

  test "should get index" do
    get elementcharts_url
    assert_response :success
  end

  test "should get new" do
    get new_elementchart_url
    assert_response :success
  end

  test "should create elementchart" do
    assert_difference('Elementchart.count') do
      post elementcharts_url, params: { elementchart: { created_on: @elementchart.created_on, element_id: @elementchart.element_id, estrength_id: @elementchart.estrength_id, eweak_id: @elementchart.eweak_id, sstrength_id: @elementchart.sstrength_id, sweak_id: @elementchart.sweak_id, updated_on: @elementchart.updated_on } }
    end

    assert_redirected_to elementchart_url(Elementchart.last)
  end

  test "should show elementchart" do
    get elementchart_url(@elementchart)
    assert_response :success
  end

  test "should get edit" do
    get edit_elementchart_url(@elementchart)
    assert_response :success
  end

  test "should update elementchart" do
    patch elementchart_url(@elementchart), params: { elementchart: { created_on: @elementchart.created_on, element_id: @elementchart.element_id, estrength_id: @elementchart.estrength_id, eweak_id: @elementchart.eweak_id, sstrength_id: @elementchart.sstrength_id, sweak_id: @elementchart.sweak_id, updated_on: @elementchart.updated_on } }
    assert_redirected_to elementchart_url(@elementchart)
  end

  test "should destroy elementchart" do
    assert_difference('Elementchart.count', -1) do
      delete elementchart_url(@elementchart)
    end

    assert_redirected_to elementcharts_url
  end
end
