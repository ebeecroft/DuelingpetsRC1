require 'test_helper'

class SuspendedtimelimitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @suspendedtimelimit = suspendedtimelimits(:one)
  end

  test "should get index" do
    get suspendedtimelimits_url
    assert_response :success
  end

  test "should get new" do
    get new_suspendedtimelimit_url
    assert_response :success
  end

  test "should create suspendedtimelimit" do
    assert_difference('Suspendedtimelimit.count') do
      post suspendedtimelimits_url, params: { suspendedtimelimit: { created_on: @suspendedtimelimit.created_on, emeraldfines: @suspendedtimelimit.emeraldfines, from_user_id: @suspendedtimelimit.from_user_id, pointfines: @suspendedtimelimit.pointfines, reason: @suspendedtimelimit.reason, timelimit: @suspendedtimelimit.timelimit, user_id: @suspendedtimelimit.user_id } }
    end

    assert_redirected_to suspendedtimelimit_url(Suspendedtimelimit.last)
  end

  test "should show suspendedtimelimit" do
    get suspendedtimelimit_url(@suspendedtimelimit)
    assert_response :success
  end

  test "should get edit" do
    get edit_suspendedtimelimit_url(@suspendedtimelimit)
    assert_response :success
  end

  test "should update suspendedtimelimit" do
    patch suspendedtimelimit_url(@suspendedtimelimit), params: { suspendedtimelimit: { created_on: @suspendedtimelimit.created_on, emeraldfines: @suspendedtimelimit.emeraldfines, from_user_id: @suspendedtimelimit.from_user_id, pointfines: @suspendedtimelimit.pointfines, reason: @suspendedtimelimit.reason, timelimit: @suspendedtimelimit.timelimit, user_id: @suspendedtimelimit.user_id } }
    assert_redirected_to suspendedtimelimit_url(@suspendedtimelimit)
  end

  test "should destroy suspendedtimelimit" do
    assert_difference('Suspendedtimelimit.count', -1) do
      delete suspendedtimelimit_url(@suspendedtimelimit)
    end

    assert_redirected_to suspendedtimelimits_url
  end
end
