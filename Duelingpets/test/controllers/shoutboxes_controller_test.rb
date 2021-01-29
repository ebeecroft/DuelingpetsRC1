require 'test_helper'

class ShoutboxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shoutbox = shoutboxes(:one)
  end

  test "should get index" do
    get shoutboxes_url
    assert_response :success
  end

  test "should get new" do
    get new_shoutbox_url
    assert_response :success
  end

  test "should create shoutbox" do
    assert_difference('Shoutbox.count') do
      post shoutboxes_url, params: { shoutbox: { box_open: @shoutbox.box_open, capacity: @shoutbox.capacity, user_id: @shoutbox.user_id } }
    end

    assert_redirected_to shoutbox_url(Shoutbox.last)
  end

  test "should show shoutbox" do
    get shoutbox_url(@shoutbox)
    assert_response :success
  end

  test "should get edit" do
    get edit_shoutbox_url(@shoutbox)
    assert_response :success
  end

  test "should update shoutbox" do
    patch shoutbox_url(@shoutbox), params: { shoutbox: { box_open: @shoutbox.box_open, capacity: @shoutbox.capacity, user_id: @shoutbox.user_id } }
    assert_redirected_to shoutbox_url(@shoutbox)
  end

  test "should destroy shoutbox" do
    assert_difference('Shoutbox.count', -1) do
      delete shoutbox_url(@shoutbox)
    end

    assert_redirected_to shoutboxes_url
  end
end
