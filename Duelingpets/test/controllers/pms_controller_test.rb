require 'test_helper'

class PmsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pm = pms(:one)
  end

  test "should get index" do
    get pms_url
    assert_response :success
  end

  test "should get new" do
    get new_pm_url
    assert_response :success
  end

  test "should create pm" do
    assert_difference('Pm.count') do
      post pms_url, params: { pm: { created_on: @pm.created_on, message: @pm.message, pmbox_id: @pm.pmbox_id, title: @pm.title, user1_unread: @pm.user1_unread, user2_unread: @pm.user2_unread, user_id: @pm.user_id } }
    end

    assert_redirected_to pm_url(Pm.last)
  end

  test "should show pm" do
    get pm_url(@pm)
    assert_response :success
  end

  test "should get edit" do
    get edit_pm_url(@pm)
    assert_response :success
  end

  test "should update pm" do
    patch pm_url(@pm), params: { pm: { created_on: @pm.created_on, message: @pm.message, pmbox_id: @pm.pmbox_id, title: @pm.title, user1_unread: @pm.user1_unread, user2_unread: @pm.user2_unread, user_id: @pm.user_id } }
    assert_redirected_to pm_url(@pm)
  end

  test "should destroy pm" do
    assert_difference('Pm.count', -1) do
      delete pm_url(@pm)
    end

    assert_redirected_to pms_url
  end
end
