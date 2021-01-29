require 'test_helper'

class MainplaylistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mainplaylist = mainplaylists(:one)
  end

  test "should get index" do
    get mainplaylists_url
    assert_response :success
  end

  test "should get new" do
    get new_mainplaylist_url
    assert_response :success
  end

  test "should create mainplaylist" do
    assert_difference('Mainplaylist.count') do
      post mainplaylists_url, params: { mainplaylist: { channel_id: @mainplaylist.channel_id, created_on: @mainplaylist.created_on, description: @mainplaylist.description, title: @mainplaylist.title, updated_on: @mainplaylist.updated_on, user_id: @mainplaylist.user_id } }
    end

    assert_redirected_to mainplaylist_url(Mainplaylist.last)
  end

  test "should show mainplaylist" do
    get mainplaylist_url(@mainplaylist)
    assert_response :success
  end

  test "should get edit" do
    get edit_mainplaylist_url(@mainplaylist)
    assert_response :success
  end

  test "should update mainplaylist" do
    patch mainplaylist_url(@mainplaylist), params: { mainplaylist: { channel_id: @mainplaylist.channel_id, created_on: @mainplaylist.created_on, description: @mainplaylist.description, title: @mainplaylist.title, updated_on: @mainplaylist.updated_on, user_id: @mainplaylist.user_id } }
    assert_redirected_to mainplaylist_url(@mainplaylist)
  end

  test "should destroy mainplaylist" do
    assert_difference('Mainplaylist.count', -1) do
      delete mainplaylist_url(@mainplaylist)
    end

    assert_redirected_to mainplaylists_url
  end
end
