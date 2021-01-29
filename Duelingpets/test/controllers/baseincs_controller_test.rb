require 'test_helper'

class BaseincsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @baseinc = baseincs(:one)
  end

  test "should get index" do
    get baseincs_url
    assert_response :success
  end

  test "should get new" do
    get new_baseinc_url
    assert_response :success
  end

  test "should create baseinc" do
    assert_difference('Baseinc.count') do
      post baseincs_url, params: { baseinc: { amount: @baseinc.amount, name: @baseinc.name } }
    end

    assert_redirected_to baseinc_url(Baseinc.last)
  end

  test "should show baseinc" do
    get baseinc_url(@baseinc)
    assert_response :success
  end

  test "should get edit" do
    get edit_baseinc_url(@baseinc)
    assert_response :success
  end

  test "should update baseinc" do
    patch baseinc_url(@baseinc), params: { baseinc: { amount: @baseinc.amount, name: @baseinc.name } }
    assert_redirected_to baseinc_url(@baseinc)
  end

  test "should destroy baseinc" do
    assert_difference('Baseinc.count', -1) do
      delete baseinc_url(@baseinc)
    end

    assert_redirected_to baseincs_url
  end
end
