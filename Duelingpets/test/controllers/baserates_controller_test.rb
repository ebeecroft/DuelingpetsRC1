require 'test_helper'

class BaseratesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @baserate = baserates(:one)
  end

  test "should get index" do
    get baserates_url
    assert_response :success
  end

  test "should get new" do
    get new_baserate_url
    assert_response :success
  end

  test "should create baserate" do
    assert_difference('Baserate.count') do
      post baserates_url, params: { baserate: { amount: @baserate.amount, created_on: @baserate.created_on, name: @baserate.name } }
    end

    assert_redirected_to baserate_url(Baserate.last)
  end

  test "should show baserate" do
    get baserate_url(@baserate)
    assert_response :success
  end

  test "should get edit" do
    get edit_baserate_url(@baserate)
    assert_response :success
  end

  test "should update baserate" do
    patch baserate_url(@baserate), params: { baserate: { amount: @baserate.amount, created_on: @baserate.created_on, name: @baserate.name } }
    assert_redirected_to baserate_url(@baserate)
  end

  test "should destroy baserate" do
    assert_difference('Baserate.count', -1) do
      delete baserate_url(@baserate)
    end

    assert_redirected_to baserates_url
  end
end
