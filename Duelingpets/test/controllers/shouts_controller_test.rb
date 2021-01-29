require 'test_helper'

class ShoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shout = shouts(:one)
  end

  test "should get index" do
    get shouts_url
    assert_response :success
  end

  test "should get new" do
    get new_shout_url
    assert_response :success
  end

  test "should create shout" do
    assert_difference('Shout.count') do
      post shouts_url, params: { shout: { bookgroup_id: @shout.bookgroup_id, created_on: @shout.created_on, message: @shout.message, reviewed: @shout.reviewed, reviewed_on: @shout.reviewed_on, shoutbox_id: @shout.shoutbox_id, updated_on: @shout.updated_on, user_id: @shout.user_id } }
    end

    assert_redirected_to shout_url(Shout.last)
  end

  test "should show shout" do
    get shout_url(@shout)
    assert_response :success
  end

  test "should get edit" do
    get edit_shout_url(@shout)
    assert_response :success
  end

  test "should update shout" do
    patch shout_url(@shout), params: { shout: { bookgroup_id: @shout.bookgroup_id, created_on: @shout.created_on, message: @shout.message, reviewed: @shout.reviewed, reviewed_on: @shout.reviewed_on, shoutbox_id: @shout.shoutbox_id, updated_on: @shout.updated_on, user_id: @shout.user_id } }
    assert_redirected_to shout_url(@shout)
  end

  test "should destroy shout" do
    assert_difference('Shout.count', -1) do
      delete shout_url(@shout)
    end

    assert_redirected_to shouts_url
  end
end
