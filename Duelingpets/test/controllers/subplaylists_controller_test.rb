require 'test_helper'

class SubplaylistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subplaylist = subplaylists(:one)
  end

  test "should get index" do
    get subplaylists_url
    assert_response :success
  end

  test "should get new" do
    get new_subplaylist_url
    assert_response :success
  end

  test "should create subplaylist" do
    assert_difference('Subplaylist.count') do
      post subplaylists_url, params: { subplaylist: { collab_mode: @subplaylist.collab_mode, created_on: @subplaylist.created_on, description: @subplaylist.description, fave_folder: @subplaylist.fave_folder, mainplaylist_id: @subplaylist.mainplaylist_id, privatesubplaylist: @subplaylist.privatesubplaylist, title: @subplaylist.title, updated_on: @subplaylist.updated_on, user_id: @subplaylist.user_id } }
    end

    assert_redirected_to subplaylist_url(Subplaylist.last)
  end

  test "should show subplaylist" do
    get subplaylist_url(@subplaylist)
    assert_response :success
  end

  test "should get edit" do
    get edit_subplaylist_url(@subplaylist)
    assert_response :success
  end

  test "should update subplaylist" do
    patch subplaylist_url(@subplaylist), params: { subplaylist: { collab_mode: @subplaylist.collab_mode, created_on: @subplaylist.created_on, description: @subplaylist.description, fave_folder: @subplaylist.fave_folder, mainplaylist_id: @subplaylist.mainplaylist_id, privatesubplaylist: @subplaylist.privatesubplaylist, title: @subplaylist.title, updated_on: @subplaylist.updated_on, user_id: @subplaylist.user_id } }
    assert_redirected_to subplaylist_url(@subplaylist)
  end

  test "should destroy subplaylist" do
    assert_difference('Subplaylist.count', -1) do
      delete subplaylist_url(@subplaylist)
    end

    assert_redirected_to subplaylists_url
  end
end
