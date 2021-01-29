require 'test_helper'

class DifficultiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @difficulty = difficulties(:one)
  end

  test "should get index" do
    get difficulties_url
    assert_response :success
  end

  test "should get new" do
    get new_difficulty_url
    assert_response :success
  end

  test "should create difficulty" do
    assert_difference('Difficulty.count') do
      post difficulties_url, params: { difficulty: { created_on: @difficulty.created_on, emeralddebt: @difficulty.emeralddebt, emeraldloan: @difficulty.emeraldloan, name: @difficulty.name, pointdebt: @difficulty.pointdebt, pointloan: @difficulty.pointloan } }
    end

    assert_redirected_to difficulty_url(Difficulty.last)
  end

  test "should show difficulty" do
    get difficulty_url(@difficulty)
    assert_response :success
  end

  test "should get edit" do
    get edit_difficulty_url(@difficulty)
    assert_response :success
  end

  test "should update difficulty" do
    patch difficulty_url(@difficulty), params: { difficulty: { created_on: @difficulty.created_on, emeralddebt: @difficulty.emeralddebt, emeraldloan: @difficulty.emeraldloan, name: @difficulty.name, pointdebt: @difficulty.pointdebt, pointloan: @difficulty.pointloan } }
    assert_redirected_to difficulty_url(@difficulty)
  end

  test "should destroy difficulty" do
    assert_difference('Difficulty.count', -1) do
      delete difficulty_url(@difficulty)
    end

    assert_redirected_to difficulties_url
  end
end
