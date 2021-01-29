require 'test_helper'

class DreyoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dreyore = dreyores(:one)
  end

  test "should get index" do
    get dreyores_url
    assert_response :success
  end

  test "should get new" do
    get new_dreyore_url
    assert_response :success
  end

  test "should create dreyore" do
    assert_difference('Dreyore.count') do
      post dreyores_url, params: { dreyore: { cap: @dreyore.cap, change: @dreyore.change, created_on: @dreyore.created_on, cur: @dreyore.cur, dragonhoard_id: @dreyore.dragonhoard_id, extracted: @dreyore.extracted, name: @dreyore.name, price: @dreyore.price, updated_on: @dreyore.updated_on } }
    end

    assert_redirected_to dreyore_url(Dreyore.last)
  end

  test "should show dreyore" do
    get dreyore_url(@dreyore)
    assert_response :success
  end

  test "should get edit" do
    get edit_dreyore_url(@dreyore)
    assert_response :success
  end

  test "should update dreyore" do
    patch dreyore_url(@dreyore), params: { dreyore: { cap: @dreyore.cap, change: @dreyore.change, created_on: @dreyore.created_on, cur: @dreyore.cur, dragonhoard_id: @dreyore.dragonhoard_id, extracted: @dreyore.extracted, name: @dreyore.name, price: @dreyore.price, updated_on: @dreyore.updated_on } }
    assert_redirected_to dreyore_url(@dreyore)
  end

  test "should destroy dreyore" do
    assert_difference('Dreyore.count', -1) do
      delete dreyore_url(@dreyore)
    end

    assert_redirected_to dreyores_url
  end
end
